class AuthorsController < ApplicationController
   def index
      @authors = Authors.all
   end

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

      if params[:title].nil? && !params[:name].nil?
         param['Author'] = params[:name]
         
      elsif !params[:title].nil? && !params[:name].nil?
         param['Author'] = params[:name]
      else
         param['Title'] = params[:title]
      end
      @res = req.get(query: param)

      # Parsed response
      response = Response.new(@res).to_h
      parsed_response = response['ItemSearchResponse']['Items']['Item']

      if parsed_response[0]['ItemAttributes']['Author'] == params[:name]
         @new_author = params[:name]
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
      @add_author = Author.create(name: params[:name])

      redirect_to 'show'
   end

   def show
      @author = Author.find(params[:id])
   end


end