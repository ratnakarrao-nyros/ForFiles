#!/usr/bin/env ruby
#
# Simple command-line search script.
#
# Originally by Paul Legato (plegato@nks.net), 4/22/06.
#
# Copyright (C) 2006 Networked Knowledge Systems, Inc.
# Copyright (C) 2006,2007 Olly Betts
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
# USA

require 'xapian'


class Query < ActiveRecord::Base


	def self.search_in_files(str)
		queryStr=Array[str]
		queryStr[0].rstrip!
		queryString=queryStr.join(' ')
		#puts "=================Query String================"
		#puts queryString

	    #query_nopunc = queryString.gsub(/[^a-z0-9:\.\/_]/i, " ")
            #query_nopunc = query_nopunc.gsub(/\s+/, " ")
            #words = query_nopunc.split(" ")
            # Remove anything with a :, . or / in it
            #words = words.find_all {|o| !o.match(/(:|\.|\/)/) }
            #words = words.find_all {|o| !o.match(/^(AND|NOT|OR|XOR)$/) }
            

		#cputs "Words array is ......... #{words.to_s}"

		


		puts "Query is :- #{queryString}"
		# Open the database for searching.
		begin
		database = Xapian::Database.new("spider.db")

		#database = Xapian::WritableDatabase.new('spider.db', Xapian::DB_CREATE_OR_OPEN)
		# Start an enquire session.
		enquire = Xapian::Enquire.new(database)
		#puts "Enquire methods ================="
		#puts enquire.methods
		# Parse the query string to produce a Xapian::Query object.
		qp = Xapian::QueryParser.new()
		stemmer = Xapian::Stem.new("english")
		qp.stemmer = stemmer
		qp.database = database

		#qp.add_prefix("CoffeeScript", "XZ")
		#Search both subject and body if no field is specified:
		#qp.add_prefix("", "XZ");
		#qp.add_prefix("subject", "X");
		#Search just the subject if 'subject:' is specified:
		#qp.add_prefix("subject", "S");
		#Xapian::Query query = qp.parse_query(user_query_string);
		
		
		  		
		


		qp.default_op =Xapian::Query::OP_OR
		qp.stemming_strategy = Xapian::QueryParser::STEM_SOME
		
		#clean_text = queryString.gsub(/\b([a-z])\*/i, "\\1").gsub(/[^\w\*\s:]/u, "")	

		#puts "cleantext ---------->#{clean_text}"

		#text='"'+clean_text+'"'
		#puts "text is ----> #{text}"
	
		query = qp.parse_query(queryString, Xapian::QueryParser::FLAG_WILDCARD | 	    							   Xapian::QueryParser::FLAG_BOOLEAN | 							   Xapian::QueryParser::FLAG_PHRASE)
		#query = Xapian::Query.new(Xapian::Query::MatchAll)
	
			
	
	
		puts "Parsed query is: #{query.description()}"

		# Find the top 10 results for the query.
		enquire.query = query
		matchset = enquire.mset(0,database.doccount)
		puts "Document Count ------> #{database.doccount}"

		# Display the results.
		puts "#{matchset.matches_estimated()} results found."
		puts "Matches 1-#{matchset.size}:\n"

		matchset.matches.each_with_index {|m,index|
		  puts "#{m.rank + 1}: #{m.percent}% docid=#{m.docid} docname=#{m.document.value(m.docid)}   [#{m.document.data[0..10]} ]\n"
			enquire.matching_terms(m.docid).each do |value|
				 puts value.term				
			end
		}
		matchset
	rescue Exception => e
		puts e.message
	end
end
end

