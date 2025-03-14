class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = Place.find_by(id: params["place_id"])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id]  # Assign entry to the logged-in user

    if @entry.save
      redirect_to "/places/#{@entry.place_id}", notice: "Entry created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.permit(:title, :description, :occurred_on, :place_id)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to create an entry."
    end
  end
end
