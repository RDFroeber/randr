class Search

   def new_favorites
      req = Vacuum.new
      path = File.join(Rails.root, 'config', 'amazon.yml')
         if File.exists?(path)
           req.configure(YAML.load_file(path))
         end
      
      param = {'Operation' => 'ItemSearch', 
         'ResponseGroup' => 'ItemAttributes',
         'SearchIndex' => 'Books', 
         'Sort' => '-publication_date'
         }

      user = User.first

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
      # binding.pry
      return @lookup
   end

   def save_favorites(lookup)
      req = Vacuum.new
      path = File.join(Rails.root, 'config', 'amazon.yml')
         if File.exists?(path)
           req.configure(YAML.load_file(path))
         end
      
      param = {'Operation' => 'ItemLookup', 
         'IdType' => 'ISBN',
         'ResponseGroup' => 'ItemAttributes,Images',
         'SearchIndex' => 'Books', 
         }

      @lookup.each do |isbn|
         param['ItemId'] = isbn
         res = req.get(query: param)
         
         # Parsed response
         response = Response.new(res).to_h
         new_book = response['ItemLookupResponse']['Items']['Item']
         new_book.each do |info|
            title = info["ItemAttributes"]["Title"]
            author = info["ItemAttributes"]["Author"]
            isbn = info["ItemAttributes"]["ISBN"]
            published_date = info["ItemAttributes"]["PublicationDate"]
            img_url_sm = info["MediumImage"]["URL"]
            img_url_lg = info["LargeImage"]["URL"]

            author_id = Author.find_by(name: author).id
            Book.create(title: title, isbn: isbn, published_date: published_date, img_url_sm: img_url_sm, img_url_lg: img_url_lg, future_release: true)
         end
      end
   end

end

# lookup = Search.new
# search = lookup.new_favorites
# Search.save_favorites(search)