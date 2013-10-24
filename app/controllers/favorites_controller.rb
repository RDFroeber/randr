class FavoritesController < ApplicationController
   def destroy
      redirect_to user_path(@user)
   end
end