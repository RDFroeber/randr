class AuthorsController < ApplicationController
   def index
      @authors = Authors.all
   end

   def new
      # Send Amazon API request using:
      # params = {'Operation' => 'ItemSearch', 'ResponseGroup' => 'ItemAttributes', 'Author' => '#{params[:name]}', 'SearchIndex' => 'Books', 'Sort' => 'salesrank'}
      # res = req.get(query: params)     
      # return-> authors.each do |author|
      # @author[i] = author["ItemAttributes"]["Author"]
      # end 

      params[:name]

      params[:title]
   end

   def create
      @author = Author.create(name: "#{params[:name]}", ) 
      params[:name]
   end

   def show
   end


end