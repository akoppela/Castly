module Tartly
  class Base
    attr_accessor :host, :port, :path
    
    CHECK_WAIT = 1
    CHECK      = 2
    DOWNLOAD   = 4
    SEED       = 8
    STOPPED    = 16
    
    
    def initialize(host = nil, port = nil, path = nil)
      @config = YAML.load_file(Rails.root + "config/torrent.yml")
      @host = host || @config["atb_1"]["host"] #TODO Rewrite to many downloaders machine
      @port = port || @config["atb_1"]["port"]
      @path = path || @config["atb_1"]["path"]
    end
    
    class << self
      def add(torrent_file_url)
        process 'torrent-add', 'filename' => torrent_file_url
      end
    
      def get_info(ids = nil)
        args = {'fields' => ["id","totalSize","downloadDir", "percentDone", "files", "status"]}
        args["ids"] = ids if ids.present?
        process 'torrent-get', args
      end
    
      def stop(ids)
         process 'torrent-stop', 'ids' => Array.wrap(ids)
      end
      
      def start(ids)
         process 'torrent-start', 'ids' => Array.wrap(ids)
      end
      
      def reannounce(ids)
        process 'torrent-reannounce', 'ids' => Array.wrap(ids)
      end
      
      def process(method, args = {}, headers = {})
        (@base ||= new).send_request(method, args, headers)
      end
    end
    
    
    def send_request(method_name, args = {}, headers = {})      
      body = { :method => method_name, :arguments => args}.to_json
      res = Net::HTTP.start(host, port) {|http|
        http.post(path, body, headers)
      }
      return ActiveSupport::JSON.decode(res.body) if res.is_a?(Net::HTTPOK)
      send_request(method_name,args, headers.merge('X-Transmission-Session-Id' => res['X-Transmission-Session-Id'])) if res.is_a?(Net::HTTPConflict)
    end
  end
end