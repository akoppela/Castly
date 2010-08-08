require 'rubygems'
require 'logger'
require "yaml"
require 'ftools'
require 'open3'
require 'thread'
module Castly
  module Transcoding

    class << self
      attr_accessor :log, :config, :transfer_queue
      def start(file_path, output, config = nil)
        configure
        Thread.new { start_indexer(output) }.run
        process_ffmpeg(file_path, output)
        stop_indexer
      end
      
      
      def configure
        @config = YAML::load(IO.read("config.yml"))
        @log = Logger.new("debug.log")
        @transfer_queue = Queue.new
      end
      
      def process_ffmpeg(path, output_dir)
        encoding_profile = @config['encoding_profile'] #TODO
        Transcoding.log.debug("Base ffmpeg_command: #{@config[encoding_profile]['ffmpeg_command']}")
        command = @config[encoding_profile]['ffmpeg_command'] % [path, @config['segmenter_binary'], @config['segment_length'], output_dir, @config['segment_prefix'] + '_' + encoding_profile, encoding_profile]
        
        Transcoding.log.debug("Executing: #{command}")
        Open3.popen3(command) do |stdin, stdout, stderr|
          @stop_stdin = stdin
          
          stderr.each("\r") do |line|
            if line =~ /segmenter: (.*)/i
              Transcoding.log.debug("Segment command #{encoding_profile}: *#{$1}*")
              @transfer_queue << $1
            end

            if line =~ /ffmpeg/i 
              Transcoding.log.debug("Encoder #{encoding_profile}: #{line}")
            end

            if line =~ /error/i
              Transcoding.log.error("Encoder #{encoding_profile}: #{line}")
            end
          end
        end

        Transcoding.log.debug("Return code from #{encoding_profile}: #{$?}")

        raise "WTF OLALA" if $?.exitstatus != 0

      end
      
      def stop_indexer
        $exit = true
      end
  
      SLEEP = 3
      def start_indexer(output_dir)
        @log.info('Transfer thread started')
        loop do
          value = @transfer_queue.pop

          unless value
            sleep(SLEEP)
          else
            @log.info("Transfer initiated with value = *#{value}*");
            create_index_and_run_transfer(value,output_dir)
          end
          break if $exit
        end
      ensure
        @log.info('Transfer thread finished')
      end
    
      
      def create_index_and_run_transfer(value,output_dir)
        @log.debug('Creating index')
        (first_segment, last_segment, stream_end, encoding_profile) = value.strip.split(%r{,\s*})
        index_segment_count = @config['index_segment_count']
        segment_duration = @config['segment_length']
        output_prefix =  @config['segment_prefix']
        encoding_profile = encoding_profile
        http_prefix = @config['url_prefix']
        first_segment = first_segment.to_i
        last_segment = last_segment.to_i
        stream_end = stream_end.to_i == 1
        index_file_path = "#{output_dir}/index.m3u8"
        File.open(index_file_path, 'a') do |index_file|
          if last_segment == first_segment
            index_file.write("#EXTM3U\n")
            index_file.write("#EXT-X-TARGETDURATION:#{segment_duration}\n")
          end
          result_file_name = "#{output_prefix}_#{encoding_profile}-%05u.ts\n" % last_segment
          index_file.write("#EXT-X-MEDIA-SEQUENCE:#{last_segment}\n")
          index_file.write("#EXTINF:#{segment_duration}, no desc\n")
          index_file.write("#{http_prefix}#{result_file_name}\n")
          index_file.write("#EXT-X-ENDLIST\n")  if stream_end
        end
        
        @log.debug('Done creating index')
      end

      
            
    end
  end
end

Castly::Transcoding.start( "/root/1.avi", "/srv/apps/castly/video")