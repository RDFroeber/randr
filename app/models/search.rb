class Search
   before_action :config_amz, :config_goodr

   def new_favorites
      req = Vacuum.new
      
      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes',
         'SearchIndex' => 'Books', 
         'Sort' => '-publication_date'
         }

      user = User.first
      # FIXME custom users?

      @lookup = []
      user.authors.each do |author|
         if author.alive
            param['Author'] = author.name
            res = req.get(query: param)
            # Parsed response
            response = Response.new(res).to_h

            books = response['ItemSearchResponse']['Items']['Item']
            
            books.each do |book|
               if !book["ItemAttributes"]["ISBN"].nil? && book["ItemAttributes"]["Binding"] != "Audio CD" && book["ItemAttributes"]["Binding"] != "Kindle Edition" && book["ItemAttributes"]["Languages"]["Language"][0]["Name"] == "English" && Date.parse(book["ItemAttributes"]["PublicationDate"]) >= Date.today
               @lookup.push(book["ItemAttributes"]["ISBN"])
               end  
            end 
         end
      end

      return @lookup
   end

   def save_favorites(lookup)
      req = Vacuum.new
      
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

            author_id = Author.find_by(name: author).id if !author.is_a? Enumerable
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
            binding.pry
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
