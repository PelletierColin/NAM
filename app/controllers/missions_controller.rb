class MissionsController < ApplicationController
  before_action :must_be_logged,   only: [:new, :create, :update, :prepare_assets, :add_assets]
  before_action :get_mission,      only: [:show, :update, :prepare_assets, :add_assets]

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
    @assets = @mission.assets
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

  def prepare_assets
    @assets = []
    Asset.all.each do |asset|
      if Mission.joins(:assets).where('assets.id =  ?', asset.id).where('ending_date >= ?', DateTime.now).count == 0
        @assets.push(asset)
      end
    end
    @assets += Asset.left_outer_joins(:asset_missions).where( asset_missions: { id: nil } )
    @assets = @assets.uniq
  end

  def add_assets
    if params && params.key?("assets_id")
      params["assets_id"].each do |asset_id|
        asset_mission = AssetMission.new()
        asset_mission.mission = @mission
        asset_mission.asset = Asset.find_by(id: asset_id)
        asset_mission.user = current_logged_user
        if !asset_mission.save
          flash[:danger] = "Error when trying to assign the \""+asset_mission.asset.product_serial+" "+asset_mission.asset.description+"\" to this mission. "+asset_mission.errors.full_messages.to_sentence
          break
        end
      end
    else
      flash[:warning] = "Select an asset related to this mission."
    end
    redirect_to mission_prepare_assets_path(@mission)
  end

  def get_mission
    @mission = Mission.find_by(id: params["id"]) || Mission.find_by(id: params["mission_id"])
    if !@mission
      render_404
    end
  end

  def mission_params
    params.require(:mission).permit(:project_name, :description, :starting_date, :ending_date)
  end

end
