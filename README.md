ForFiles
========

1.ABOUT THIS APPLICATION:

========================

ForFiles  provides an easy-to-use interface for uploading , browsing ,deleting and sending files .


Features

----------

    Uploading files(.pdf,.txt,.doc,.png,.jpg,.jpeg,.gif) to local Directory
    
    Display files from local Directory
    
    Deleting files from Directory
    
    Showing files in Lightbox on click event
    
    Sending files as an attachment to appropriate users
 


2.REQUIREMENTS:

===============

 Rails 3.2 , Ruby 1.8.7 versions and higher.

  	For sending mail just do following modifications

	open config/environments/development.rb file and then
		
	cofigure the following
  
		:user_name => "your_mail_id@gmail.com",
    
          	:password => "your_mail_password"	
            
	open app/mailer/user_mailer.rb and then
  
		cofigure the following
    
		:default :from => "your_mail_id@gmail.com"


	For uploading files create 'uploads' folder inside public and assets/image folder
  
	
	For extracting text from .pdf and .doc create 'storage' folder and then create 'doc','pdf','txt'
  
		folders inside 'storage' folder

		 

3.Future Extensions:

====================

	As of now we wanted to show file operations with rails without need of Database and without
  
	any gem help to upload and browse files. In future we will extend this applications for searching 
	
	content in files and more.We welcome your contribution.
	
Screenshots
 
 ================================
 
 	<p>
 	<img style="max-width:100%;" title="index" alt="index" src="https://github.com/ratnakarrao-nyros/ForFiles/raw/master/ForFiles/sceenshots/index.png">
 	</p>
 	


