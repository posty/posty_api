module Folder
  MAIL_ROOT_FOLDER = "/srv/vmail"
  MAIL_USER = "vmail"
  MAIL_GROUP = MAIL_USER
  STORAGE_CLASS = "mdbox/storage" # Possible values "mdbox", "Maildir", "mbox"
  
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
  
  def change_permissions(folder_array)
    current_folder = ""
    folder_array.each do |folder|
      current_folder += folder + "/"
      FileUtils.chown MAIL_USER, MAIL_GROUP, MAIL_ROOT_FOLDER + "/" + current_folder
    end
  end
end