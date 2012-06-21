require 'spec_helper'

describe DataFile do
	it "returns saves file in public/upload Directory..."
		upload=Factory(:datafile,upload: "sample.txt")
  	   	DataFile.save("sample.txt").should == upload
        end
	 it "is invalid without a lastname" do
    		Factory.build(:datafile, upload: nil).should_not be_valid
 	 end

end



   
