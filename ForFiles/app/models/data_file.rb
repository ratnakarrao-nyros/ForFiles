require 'fileutils'
class DataFile < ActiveRecord::Base
	
	def self.save(upload)
		ext_name=File.extname(upload.original_filename)
		if ext_name == '.jpg' or ext_name == '.jpeg' or ext_name == '.gif' or ext_name == '.png' 
			File.open(File.join(IMAGE_PATH,upload.original_filename),'wb') do |file|
				file.write(upload.read)			
			end
			File.open(File.join(DIRECTORY_PATH, upload.original_filename), 'wb') do |file|
		  		file.write(upload.read)
		 	end
		else
		  	File.open(File.join(DIRECTORY_PATH, upload.original_filename), 'wb') do |file|
		  		file.write(upload.read)
		 	end			
		end	
	end
	
	def self.read
		Dir.entries(DIRECTORY_PATH)			
	end
	
	def self.edit(id)
		Dir.entries(DIRECTORY_PATH).each_with_index do |file_name,index| 
			if index.to_s == id					
			@file_name=file_name			
			end	
		end
		@file_name	
	end	
	
	#for extracting text from pdf and .doc files	
	def self.text_extract(path,file,ext_name)
		if ext_name == '.doc' 
			Docsplit.extract_text(path,:ocr => false,:output =>'storage/doc')
			@path=File.join('storage/doc',file.chomp(File.extname(file))+'.txt')		
		elsif ext_name == '.pdf'
			Docsplit.extract_text(path,:ocr => false,:output =>'storage/pdf')
			@path=File.join('storage/pdf',file.chomp(File.extname(file))+'.txt')
		else	
			@path=path
		end
	end
	
	def self.delete(id)
		Dir.entries(DIRECTORY_PATH).each_with_index do |file_name,index|
			if index.to_s == id
				@file_name=file_name
				puts "=============#{@file_name}=========="
				if File.file?(File.join(DIRECTORY_PATH,file_name)) 
					puts File.join(DIRECTORY_PATH,file_name)
					FileUtils.rm(File.join(DIRECTORY_PATH,file_name))
				end	
			end		
		end
	end


	def self.search(search_key)
		#Dir.entries(DIRECTORY_PATH).each do |file|
		#	 puts  /file/.match(search_key) 				
		#end	
	end



end



