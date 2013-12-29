module Folder
  #TODO: Make configurable
  MAIL_ROOT_FOLDER = "/var/vmail"
  
  def move_folder
    if File.directory?(get_folder(name_change.last))
      error!("A folder with this name already exists.", 400)
    else
      FileUtils.mv get_folder(name_change.first), get_folder(name_change.last)
    end
  end

  def remove_folder
    FileUtils.rm_rf get_folder
  end
end