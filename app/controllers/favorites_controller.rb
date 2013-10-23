class FavoritesController < ApplicationController

   def new

   end

   def create
      @fav = Favorite.create(user_id: params[:user_id], author_id: params[:name])
      redirect_to favorite_path(@fav)
   end

   def show
      
   end
end