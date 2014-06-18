module Folder
  MAIL_ROOT_FOLDER = "/var/vmail"
  
  def move_folder
    if ENV["RACK_ENV"] == "production"
      if File.directory?(get_folder(name_change.last))
        error!("A folder with this name already exists.", 400)
      else
        FileUtils.mv get_folder(name_change.first), get_folder(name_change.last)
      end
    end
  end

  def remove_folder
    if ENV["RACK_ENV"] == "production"
      FileUtils.rm_rf get_folder
    end
  end
end