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
      render :login_form
    end
  end

  def show
    @user = User.find(params[:id])
    @parties = @user.partygoings.map(&:party)
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
