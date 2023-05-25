class MoviesController < ApplicationController
  # before_action :check_user

  def index
    @user = current_user if current_user
    @facade = MoviesFacade.new(params[:query])
  end  

  def show
    @user = current_user if current_user
    @movie = MovieFacade.new(params[:id])
  end

  private

  def check_user
    if current_user
      @user = current_user
    else
      flash[:error] = "You must be logged in to access your dashboard"
      redirect_to root_path
    end
  end
end
