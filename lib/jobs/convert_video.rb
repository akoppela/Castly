class ConvertVideo < Struct.new(:file_path)
  
  def perform
    command = "ffmpeg -y -i #{file_path} -threads 0 -s 720x400 -aspect 720:400 \
      -r 29.97 -vcodec libx264 -b 1000k -qmin 20 -qmax 50 -bufsize 10221k \
      -maxrate 1800k -acodec libfaac -ar 44100 -ac 2 -ab 128k -f ipod \
      -coder 1 -flags +loop -cmp +chroma \
      -partitions +parti8x8+parti4x4+partp8x8+partb8x8 -me_method umh -subq 8 \
      -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 \
      -b_strategy 2 -qcomp 0.6 -qdiff 4 -bf 3 -refs 4 -directpred 3 -trellis 1 \
      -flags2 +wpred+mixed_refs+dct8x8+fastpskip+mbtree -wpredp 2 \
      #{file_path}.m4v.new"
      execute_ffmpeg(command)
  end
  
  def execute_ffmpeg(comand)
    #TODO
  end
end