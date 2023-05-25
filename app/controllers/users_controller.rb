class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to login_path
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end
  
  def show
    if current_user
      @user = current_user
      @parties = @user.partygoings.map(&:party)
    else
      flash[:error] = "You must be logged in to access your dashboard"
      redirect_to root_path
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
