class FavoritesController < ApplicationController
   before_action :current_user

   def destroy
      fav = Favorite.find(params[:id])
      if fav.destroy
         redirect_to user_path(current_user)
      end
   end
end