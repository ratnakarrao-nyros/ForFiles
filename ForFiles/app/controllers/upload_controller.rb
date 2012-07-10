require 'docsplit'

class UploadController < ApplicationController
 # for home page 
 #/
 
  def index
    	render "upload.rhtml"
  end

  #for upload file action
  #/uploadFile
  
  def uploadFile
	@upload=params[:picture]
	post=DataFile.save(@upload)
   	@notice="File has been uploaded successfully"
	render "upload.rhtml"
  end

  #for reading file from Direcory
  # /readFile 

  def readFile
	@file_names=DataFile.read
	render "read"
  end 
  
  def showFile
	@data_file=DataFile.new
	@file_id=params[:id]
	@file=DataFile.edit(@file_id)
	@ext_name=File.extname(@file)
	path=File.join(DIRECTORY_PATH,@file)
	@path=DataFile.text_extract(path,@file,@ext_name)
	render "edit", :locals => { :comment => @path,:original_filename =>@file }, :layout => false, :status => :created
  end

 def delete_file
	@file_id=params[:id]
	@file=DataFile.delete(@file_id)
	render :nothing => true 
 end

  
  def send_mail
	UserMailer.registration_confirmation(params[:original_filename],params[:mail_id]).deliver
	@success="File has been sent successfully"
	@file_names=DataFile.read
	render "read"
  end

  def search
	Spider.indexing_files
	@results=Query.search_in_files(params[:key])
	if @results.blank? 
		@failure="No Results Found"
	end
	render "read"
  end

end


