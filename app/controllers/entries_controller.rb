class EntriesController < ApplicationController
  before_action :require_login

  def new
    @place = Place.find_by(id: params[:place_id])
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id]  # Ensure logged-in user is assigned
    @entry.place_id = params[:place_id] if params[:place_id]  # Assign place_id if missing
  
    if @entry.save
      redirect_to "/places/#{@entry.place_id}", notice: "Entry created successfully!"
    else
      flash[:alert] = "Failed to create entry: #{@entry.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end
  

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id, :image, :user_id)
  end
  

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to create an entry."
    end
  end
end
