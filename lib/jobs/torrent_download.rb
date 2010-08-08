class ConvertVideo < Struct.new(:id)
  def perform
    torrent = Download.find(id)
    torrent_public_path = "#{HOST}/#{torrent.file.url}"
    result = Tartly::Base.add(torrent_public_path)
    data = result["arguments"]["torrent-added"] #may be here its will be raised error
    torrent.update_attributes!(:torrent_id => data["id"] , 
              :info_hash => data["hashString"], :title => data["name"])
    create_downloaded_files(torrent)
  end
  
  def create_downloaded_files(torrent)
    result = Tartly::Base.Base.get_info(torrent.torrent_id)
    torrent_info = result["arguments"]["torrents"].first
    torrent.update_attributes!(:common_size => torrent_info["totalSize"], 
                    :procent_complete => torrent_info["percentDone"] * 100)
    torrent_info["files"].each { |file| append_file(torrent, file) }
  end
  
  def append_file(torrent, file)
    torrent.download_files.create(:title => file["name"], :common_size => file["length"],
                                  :completed_size => file["bytesCompleted"])
  end
end