class Search < ApplicationController
   before_action :config_goodr

   def new_favorites(the_user)
      req = Vacuum.new
      config_amz(req)
      
      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes',
         'SearchIndex' => 'Books', 
         'Sort' => '-publication_date'
         }

      @lookup = []
      the_user.authors.each do |author|
         if author.alive
            param['Author'] = author.name
            res = req.get(query: param)
            # Parsed response
            response = Response.new(res).to_h

            books = response['ItemSearchResponse']['Items']['Item']
            
            books.each do |book|
               if book["ItemAttributes"]["Binding"] != "Audio CD" && book["ItemAttributes"]["Binding"] != "Kindle Edition" 
                  unless book["ItemAttributes"]["PublicationDate"].nil?
                     if Date.parse(book["ItemAttributes"]["PublicationDate"]) >= Date.today
                        begin  
                           @isbn = book["ItemAttributes"]["ISBN"]
                        rescue  
                           @isbn = book["ItemAttributes"]["EISBN"]
                        end
                        @lookup.push(@isbn)
                     end
                  end
               end  
            end 
         end
      end

      return @lookup
   end

   def save_favorites(lookup)
      req = Vacuum.new
      config_amz(req)
      
      param = {'Operation' => 'ItemLookup', 
         'IdType' => 'ISBN',
         'ResponseGroup' => 'ItemAttributes,Images',
         'SearchIndex' => 'Books'
         }

      if !@lookup.is_a? Enumerable
         param['ItemId'] = @lookup.isbn
         res = req.get(query: param)
            
            # Parsed response
            response = Response.new(res).to_h

            info = response['ItemLookupResponse']['Items']['Item']

            title = info["ItemAttributes"]["Title"]
            author = info["ItemAttributes"]["Author"]
            isbn = info["ItemAttributes"]["ISBN"]
            published_date = info["ItemAttributes"]["PublicationDate"]
            if !info["MediumImage"].nil?
               @img_url_sm = info["MediumImage"]["URL"]
            end
            if !info["LargeImage"].nil?
               @img_url_lg = info["LargeImage"]["URL"]
            end

            !author.is_a? Enumerable ? author_id = Author.find_by(name: author[0]).id : author_id = Author.find_by(name: author).id
            # binding.pry 
            # FIXME Can't find an author when auhor is an array

            @book = Book.find_or_initialize_by(title: title, author_id: author_id)

            @book.isbn = isbn
            @book.published_date = published_date
            if !@img_url_sm.nil?
               @book.img_url_sm = @img_url_sm 
            end
            if !@img_url_lg.nil?
               @book.img_url_lg = @img_url_sm 
            end
      else
         @lookup.each do |isbn|
            param['ItemId'] = isbn
            res = req.get(query: param)
            
            # Parsed response
            response = Response.new(res).to_h

            info = response['ItemLookupResponse']['Items']['Item']

            title = info["ItemAttributes"]["Title"]
            author = info["ItemAttributes"]["Author"]
            isbn = info["ItemAttributes"]["ISBN"]
            published_date = info["ItemAttributes"]["PublicationDate"]
            if !info["MediumImage"].nil?
               @img_url_sm = info["MediumImage"]["URL"]
            end
            if !info["LargeImage"].nil?
               @img_url_lg = info["LargeImage"]["URL"]
            end
            # binding.pry
            author_id = Author.find_by(name: author).id
            

            @book = Book.find_or_initialize_by(title: title, author_id: author_id)

            @book.isbn = isbn
            @book.published_date = published_date
            if !@img_url_sm.nil?
               @book.img_url_sm = @img_url_sm 
            end
            if !@img_url_lg.nil?
               @book.img_url_lg = @img_url_sm 
            end

            # Book.create(title: title, author_id: author_id, isbn: isbn, published_date: published_date, img_url_sm: img_url_sm, img_url_lg: img_url_lg, future_release: true)
         end
      end
      @book.save
   end

end
