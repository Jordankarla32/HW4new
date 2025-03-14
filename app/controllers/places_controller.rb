class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by(id: params[:id])
    Rails.logger.debug "Current User ID: #{session[:user_id]}"  # Debug log
    @entries = Entry.where(place_id: @place.id, user_id: session[:user_id])  # Only fetch current user's entries
  end
  
  
  
  

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
