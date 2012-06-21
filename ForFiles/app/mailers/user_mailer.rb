
class UserMailer < ActionMailer::Base
  default :from => "your_mail_id@gmail.com"
  
  def registration_confirmation(original_filename,user)
    	attachments[original_filename] = File.read(File.join(DIRECTORY_PATH,original_filename))
   	mail(:to => user, :subject => "#{original_filename}")
  end

end


