class BooksController < ApplicationController
   def new
   end

   def search
      req = Vacuum.new
      path = File.join(Rails.root, 'config', 'amazon.yml')
         if File.exists?(path)
           req.configure(YAML.load_file(path))
         end
      
      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes,Images',
         'SearchIndex' => 'Books', 
         'Sort' => 'salesrank'
         }

      if !params[:title].nil? && params[:name].nil?
         param['Title'] = params[:title]
      elsif !params[:title].nil? && !params[:name].nil?
         param['Author'] = params[:name]
         param['Title'] = params[:title]
      else
         param['Title'] = params[:title]
      end

      @res = req.get(query: param)

      # Parsed response
      response = Response.new(@res).to_h
      parsed_response = response['ItemSearchResponse']['Items']['Item']

      @choose_book = []
      parsed_response.each do |book_obj|
         if book_obj['ItemAttributes']['Title'] == params[:title]
            @new_book = book_obj
         else
            @choose_book.push(book_obj)
         end
      end

      render :search
   end

   def create
      #if book already exists just use that data entry
      author_id = Author.find_by(name: params[:author]).id
      book = Book.find_or_initialize_by(title: params[:title], author_id: author_id)
      # TODO Impliment add book method and save book method
      
      # @add_book = book(isbn: , published_date: , img_url_sm: , img_url_lg: , buy_link:)
      # binding.pry
      # @book.save
      # binding.pry

      # # Add author to user favorites
      # fav = Favorite.find_or_initialize_by(user_id: @current_user.id, author_id: @author.id)
      # fav.save

      # redirect_to user_path(@current_user)
      redirect_to book_path(@book)
   end

   def show

   end

end