class BooksController < ApplicationController
   before_action :current_user

   def new
   end

   def search
      req = Vacuum.new
      path = File.join(Rails.root, 'config', 'amazon.yml')
         if File.exists?(path)
           req.configure(YAML.load_file(path))
         end
      
      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes',
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
 
         if !book_obj.include?('ItemAttributes') 
            @no_info = "Sorry, there is not enough information for that title."
         elsif book_obj['ItemAttributes']['Title'] == params[:title] && !book_obj['ItemAttributes']['ISBN'].nil?
            @new_book = book_obj
         elsif !book_obj['ItemAttributes']['ISBN'].nil?
            @choose_book.push(book_obj)
         end
      end

      render :search
   end

   def create
      #if book already exists just use that data entry
      author_id = Author.find_by(name: params[:author]).id
      book = Book.find_or_initialize_by(title: params[:title], author_id: author_id)

      req = Vacuum.new
      path = File.join(Rails.root, 'config', 'amazon.yml')
         if File.exists?(path)
           req.configure(YAML.load_file(path))
         end

      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes,Images',
         'SearchIndex' => 'Books', 
         'Title' => params[:title]
         }
      
      res = req.get(query: param)
         
      # Parsed response
      response = Response.new(res).to_h
      book_res = response['ItemSearchResponse']['Items']['Item'][0]

      book.isbn =  book_res['ItemAttributes']['ISBN']
      book.published_date = book_res['ItemAttributes']['PublicationDate']
      if !book_res["MediumImage"].nil?
            book.img_url_sm = book_res["MediumImage"]["URL"]
         end
         if !book_res["LargeImage"].nil?
            book.img_url_lg = book_res["LargeImage"]["URL"]
         end
      book.save
      
      # binding.pry
      # Add book to user library
      lib = Library.find_or_initialize_by(user_id: @current_user.id, book_id: book.id)
      lib.save

      redirect_to library_users_path(@current_user)
   end

   def show
   end

end