class AuthorsController < ApplicationController
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
         param['Author'] = params[:name]
      end

      @res = req.get(query: param)

      # Parsed response
      response = Response.new(@res).to_h
      parsed_response = response['ItemSearchResponse']['Items']['Item']
      binding.pry
      if parsed_response.nil?
         @no_results = "Sorry, that author could not be found. Please try a different search."
      elsif parsed_response[0]['ItemAttributes']['Author'] == params[:name]
         @new_author = params[:name]
      elsif parsed_response[0]['ItemAttributes']['Title'] == params[:title]
         @new_author = parsed_response[0]['ItemAttributes']['Author']
      else   
         choose_author = []
         parsed_response.each do |item|
            choose_author.push(item['ItemAttributes']['Author'])
            @choose_author = choose_author.uniq
         end
      end

      render :search
   end

   def create
      #if author.name already exists just use that data entry
      @author = Author.find_or_initialize_by(name: params[:name])
      @author.save
      # binding.pry

      # Add author to user favorites
      fav = Favorite.find_or_initialize_by(user_id: @current_user.id, author_id: @author.id)
      fav.save

      redirect_to user_path(@current_user)
   end

   def show
      @author = Author.find(params[:id])
   end


end