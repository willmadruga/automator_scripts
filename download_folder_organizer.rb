class DownloadFolderOrganizer

  DOWNLOAD_FOLDER = "$HOME/Downloads"

  EXTENSION = Hash[
    ".torrent" => "torrents",
    ".mov" => "movies",
    ".mp4" => "movies",
    ".mkv" => "movies",    
    ".flv" => "movies",
    ".m4v" => "movies",
    ".avi" => "movies",
    ".jpg" => "images",
    ".png" => "images",
    ".pdf" => "pdfs",
    ".mp3" => "mp3s",
    ".sh" => "apps",
    ".tar.gz" => "zips",
    ".zip" => "zips",
    ".dmg" => "apps",
    ".txt" => "misc",
    "(PSP)" => "games"    
  ]


  def initialize
    sleep 15
    organize(EXTENSION)
  end

  def move(file, to)
    origin = "#{DOWNLOAD_FOLDER}/#{file}"
    destiny = "#{DOWNLOAD_FOLDER}/#{to}/"
    `mv \"#{origin}\" \"#{destiny}\"`
  end

  def list_files
    `ls -a #{DOWNLOAD_FOLDER}`
  end
  
  def organize(col)
    list_files.split("\n").each do |f|
      col.each do |pattern,folder|
        if /#{pattern}$/.match(f)
           move(f,folder)
           message = "File #{f} moved to #{folder}"
           notify(message)
        end
      end
    end
  end
  
  def notify(message)
    `growlnotify -m #{message}`
  end
end

DownloadFolderOrganizer::new