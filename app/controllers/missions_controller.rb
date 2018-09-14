class MissionsController < ApplicationController
  before_action :must_be_logged,   only: [:new, :create, :update]
  before_action :get_mission,      only: [:show, :update]

  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    @mission.user = current_logged_user
    if @mission.save
      redirect_to missions_path(@mission.id)
    else
      flash.now[:danger] =  "Failed to create "+@mission.project_name
      render 'new'
    end
  end

  def show
    @assets = []
  end

  def update
    if @mission.update(mission_params)
      flash[:success] = "Mission successfully updated."
      redirect_to mission_path(@mission)
    else
      flash[:danger] =  "Failed to update "+@mission.project_name
      redirect_to mission_path(@mission)
    end
  end

  def get_mission
    @mission = Mission.find_by(id: params["id"])
  end

  def mission_params
    params.require(:mission).permit(:project_name, :description, :starting_date, :ending_date)
  end

end
