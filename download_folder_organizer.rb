# William :: willpaixao@gmail.com
# used by mac folder actions
class DownloadFolderOrganizer

  @@download_folder = "$HOME/Downloads"

  # extensão, pasta
  @@map = Hash[".torrent" => "torrents",
             ".mov" => "movies",
             ".jpg" => "images",
             ".pdf" => "pdfs",
             ".mp3" => "mp3s",
             ".dmg" => "apps"
            ]
                 
  def move(file, to)
    `mv \"#{@@download_folder}/#{file}\" \"#{@@download_folder}/#{to}/\"`
  end

  def list_files
    `ls -a #{@@download_folder}`
  end
  
  def organize
    list_files.split("\n").each do |f|
      @@map.each do |ext,folder|
        if f.match(ext)
          move(f,folder)
          `growlnotify -m "File #{f} moved to #{folder}"`
        end
      end
    end
  end
        
end

d = DownloadFolderOrganizer::new
d.organize