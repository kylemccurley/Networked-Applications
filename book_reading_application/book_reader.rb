require "sinatra"
require "sinatra/reloader"
require 'tilt/erubis'

not_found do
  redirect '/'
end

before do
  @contents = File.readlines('data/toc.txt')
end

helpers do
  def in_paragraphs(content)
    paragraphs = content.split("\n\n")
    paragraphs.map { |paragraph| "<p>#{paragraph}</p>" }.join
  end
end

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  title = @contents[number - 1]

  redirect "/" unless (1..@contents.size).cover?(number)
  @title = "Chapter #{number}: #{title}"
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end

get '/search' do
  @search_matches = []
  for chapter in (1..@contents.size) do
    file = File.read("data/chp#{chapter}.txt")
    title = @contents[i - 1]
    @search_matches << title if file.include?(params[:query])
  end
  erb :search
end

=begin
  Searching Algorithm:
    Information Given:
      - Titles Of Each Chapter (Not connected to the other chapter)
      - Text Contents of Each Chapter
      - Name and Value of the Query

    Iterate through each element from 1..@contents.size: |counter|
      - Reference the file of "chp#{counter}.txt"; Open the File; Read the File
      - If any text within the file contains (String#include?) the value of the 
        query search:
          - Select the current element
=end
