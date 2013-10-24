class SessionsController < ApplicationController
   def new
       render :new
   end

   def create
      # Authenticate that user and password combo is legit
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
      # Save the session
         session[:user_id] = user.id
         redirect_to user_path(user)
      else
         redirect_to new_session_path
      end
   end

   def destroy
     # session[:user_id] = nil
     # redirect_to new_user_path
   end

end