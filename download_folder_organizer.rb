class DownloadFolderOrganizer

  @@download_folder = "$HOME/Downloads"

  @@ext_map = Hash[
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
    ".txt" => "misc"
  ]

  @@pattern_map = Hash[
    "(PSP)" => "games"
  ]

  def initialize
    notify('inicializado')
    #sleep 15
    organize(@@ext_map)
    organize(@@pattern_map)
  end

  def move(file, to)
    origin = "#{@@download_folder}/#{file}"
    destiny = "#{@@download_folder}/#{to}/"
    `mv \"#{origin}\" \"#{destiny}\"`
  end

  def list_files
    `ls -a #{@@download_folder}`
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