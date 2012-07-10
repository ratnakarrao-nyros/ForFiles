#!/usr/bin/ruby
#
# Example file spider using XapianFu.  Overwrites the index on each run (./spider.db)
#
# spider.rb /path/to/index

require 'rubygems'
require 'benchmark'
#require 'xapian-fu'
class Spider < ActiveRecord::Base
 
def self.indexing_files

database = Xapian::WritableDatabase.new('spider.db', Xapian::DB_CREATE_OR_OVERWRITE)

indexer = Xapian::TermGenerator.new()
stemmer = Xapian::Stem.new("english")
indexer.stemmer = stemmer


base_path = DIRECTORY_PATH
xapian_file_name=0
index_queue = [base_path]
total_file_count = 0
indexing_time = 0.0
STDERR.write "Indexing\n"
while dir = index_queue.shift
  STDERR.write " - #{dir}: \n"
  file_count = 0
  file_data = 0
  Dir.foreach(dir) do |filename|
    # skip . and ..
    next if filename =~ /^[.]{1,2}$/
    filename = File.join(dir, filename)
    # Put any directories we find onto the queue for indexing
    if File.directory?(filename)
      index_queue << filename
      next
    end
    next unless File.file?(filename)
    #next unless filename =~ /(txt|doc|README|pdf|c|h|pl|sh|rb|py|note|xml)$/i
    file_count += 1
	puts file_count
    # Read the first 10k of data
    text = File.open(filename) { |f| f.read() }
    file_data += text.size
    # Index the data, filename and filesize

      doc = Xapian::Document.new()
      doc.data = text
	
	#puts "==========Document data============="
	#puts doc.data
   #Storing File name
     doc.add_value(file_count,File.basename(filename))	 	
	#displaying file name	
	puts doc.value(file_count)


	#Index Document
      indexer.document = doc
      indexer.index_text(text)

      # Add the document to the database
      database.set_metadata("title",filename)
      database.add_document(doc)
	#save Changes
      database.flush
	#puts "=============Meta Data ============="
	#puts database.get_metadata("title")
    bm = Benchmark.measure do
      
    end
    indexing_time += bm.real
  end
  STDERR.write("#{file_data / 1024}k in #{file_count} files\n")
  total_file_count += file_count
end
files_per_second = (total_file_count / indexing_time).round
puts "#{total_file_count} files indexed in #{indexing_time.round} seconds (#{files_per_second} per second)"
flush_time = Benchmark.measure { database.flush }.real
puts "Flush to disk took #{flush_time.round} seconds"

	#closing database
	database.close() 
end
end
