require 'spec_helper'

describe UploadController do
  describe "GET #index" do
     it "displays browsing options" do
     	get :index
     end
    it "renders the :upload view" do
     	get :index
    end
  end
  
  describe "GET #uploadFile" do
   context "with valid attributes" do
     it "saves the new file in the public/uploads Directory" do 
     	# we need to write code here if action deals with database
     end
     it "renders the :upload view" do
     	# we need to write code here if action deals with database
     end
   end
   context "with invalid attrubutes" do
     it "does not save the new file in the public/uploads Directory" do
     	
     end
   end
  end
  
  describe "GET #readFile" do
    it "reads files from public/uploads Directory" do
    	get:readFile
    end
    it "renders the :read view" do
    	get:readFile
    end
  end
  
  describe "GET #editFile" do
    it "edits the requested file " do
     	#  write code here if action deals with database
    end
    it "renders the :edit view" do
     	# write code here if action deals with database
    end
   
  end

  describe "GET #send_mail" do
    it "sends the file as an attachment to appropriate user " do
    	#  write code here if action deals with database
    end
    it "renders the :read view" do
    	#  write code here if action deals with database
    end
  end 
  
end
