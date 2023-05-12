class PartiesController < ApplicationController
  def new
    @party = Party.new
    @host = User.find(params[:id])
    @movie = MovieFacade.new(params[:movie_id])
    @users = User.where.not(id: @host.id)
  end

  def create
    @party = Party.new(party_params)
  
    if @party.save
      Partygoing.create(user_id: @party.user_id, party_id: @party.id)
      redirect_to user_path(@party.user_id), notice: 'Party was successfully created.'
    else
      @host = User.find(params[:party][:user_id]) 
      @movie = MovieFacade.new(params[:movie_id])
      @movie_id = params[:movie_id]
      @users = User.where.not(id: @host.id)       
      render :new
    end
  end

  private
  
  def party_params
    params.require(:party).permit(:duration, :datetime, :user_id, :title, :movie_runtime, user_ids: [])
  end
end
