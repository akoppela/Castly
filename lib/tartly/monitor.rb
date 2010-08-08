module Tratly
  class Monitor
    SLEEP = 5
    attr_accessor :logger
    
    def initialize(options={})
      @logger = Rails.logger
    end

    def start
      trap('TERM') {say "TERM RECIEVED, #TORRENT" ; $exit = true }
      trap('INT')  {say "INT RECIEVED, #TORRENT" ;$exit = true }

      loop do
        
        break if $exit
      end

    ensure
      say "GoodBye from Torrent Monitor"
    end

    def say(text)
      logger.info text if logger
    end

  end
end
