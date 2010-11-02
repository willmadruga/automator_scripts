# Used by mac folder actions

class DownloadFolderOrganizer
  
    @@download_folder = "$HOME/Downloads"
      
    @@ext_map = Hash[
               ".torrent" => "torrents",
               ".mov" => "movies",
               ".mp4" => "movies",
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
               ".dmg" => "apps"
      ]
           
    @@pattern_map = Hash[
                   "(PSP)" => "PSP"  
      ]       
                 
  def move(file, to)
    origin = "#{@@download_folder}/#{file}"
    destiny = "#{@@download_folder}/#{to}/"
    `mv \"#{origin}\" \"#{destiny}\"`
  end

  def list_files
    `ls -a #{@@download_folder}`
  end
  
  def organize_files
    list_files.split("\n").each do |f|
      @@ext_map.each do |ext,folder|
        if f.match(ext)
          move(f,folder)
          `growlnotify -m "File #{f} moved to #{folder}"`
        end
      end
    end
  end
  
  def organize_folders_by_name
    # this is hard-coded... any ideas?
        list_files.split("\n").each do |f|
          @@pattern_map.each do |pattern,folder|
            if f.match(pattern)
              move(f,folder)
              `growlnotify -m "File #{f} moved to #{folder}"`
            end
          end          
        end
  end
          
end

d = DownloadFolderOrganizer::new
d.organize_files
d.organize_folders_by_name