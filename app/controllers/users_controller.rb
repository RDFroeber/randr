class UsersController < ApplicationController

   before_action :authenticated!, :set_user, :authorized!, except: [:new, :create, :welcome]

   def new
      @user = User.new
      render :new
   end

   def create
      @user = User.new(user_params)

      if @user.save
         redirect_to user_path(@user)
      else
         render :new
      end
   end

   def show
      if !params[:email].nil?
           UserMailer.notify_email(current_user).deliver
      end
   end

   def library
      @user = current_user
   end

   def edit
   end

   def update
      if @user.update_attributes(user_params)
         redirect_to user_path(@user)
      else
         render :edit
      end
   end

   def destroy
      if @user.destroy
         redirect_to new_user_path
      else
         render :edit
      end
  end

  private

   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

   def set_user
      @user = User.find(params[:id])
   end

   def authorized!
      unless @user.id == session[:user_id]
          redirect_to user_path(session[:user_id])
       end 
   end

end