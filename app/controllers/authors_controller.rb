class AuthorsController < ApplicationController
   before_action :current_user, :config_goodr
   before_action :logged_in?, :authenticated!, only: [:create]

   def new
   end

   def search
      req = Vacuum.new
      config_amz(req)
      
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
         param['Author'] = params[:name]
      end

      @res = req.get(query: param)

      # Parsed response
      response = Response.new(@res).to_h
      parsed_response = response['ItemSearchResponse']['Items']['Item']

      if parsed_response.nil?
         @no_results = "Sorry, that author could not be found. Please try a different search."
      elsif parsed_response[0]['ItemAttributes']['Author'] == params[:name]
         @new_author = params[:name]
      elsif parsed_response[0]['ItemAttributes']['Title'] == params[:title]
         @new_author = parsed_response[0]['ItemAttributes']['Author']
      else   
         choose_author = []
         parsed_response.each do |item|
            if item['ItemAttributes']['Author'] != "Various" && item['ItemAttributes']['Binding'] != "Kindle Edition" && item['ItemAttributes']['Binding'] != "Audio CD" && item['ItemAttributes']['Binding'] != "Unknown Binding"
               if !item['ItemAttributes']['Author'].is_a? Enumerable
                  choose_author.push(item['ItemAttributes']['Author'])
               end
               @choose_author = choose_author.uniq.compact
            end
         end
      end
      render :search
   end

   def create
      #if author.name already exists just use that data entry
      @author = Author.find_or_initialize_by(name: params[:name])
      @author.save

      # Add author to user favorites
      fav = Favorite.find_or_initialize_by(user_id: current_user.id, author_id: @author.id)
      fav.save

      # lookup = Search.new
      # search = lookup.new_favorites(current_user)
      # lookup.save_favorites(search)
   
      redirect_to user_path(current_user)
   end

   def show
      @author = Author.find(params[:id])
   end

   def remove
      Favorite.find_by(author_id: params[:author_id]).delete
      
      redirect_to user_path(current_user)
   end

end