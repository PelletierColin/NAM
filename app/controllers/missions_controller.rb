class MissionsController < ApplicationController
  before_action :must_be_logged,   only: [:new, :create, :update, :prepare_assets, :add_assets]
  before_action :get_mission,      only: [:show, :update, :prepare_assets, :add_assets, :extract_asset]
  before_action :get_asset_mission, only: [:extract_asset]

  def index
    @missions = Mission.all.order('starting_date desc')
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
    @asset_missions = @mission.asset_missions.order('created_at desc')
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
      if !asset.has_current_mission
        @assets.push(asset)
      end
    end
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

  def extract_asset
    @asset_mission.extracted_at = DateTime.now
    if !@asset_mission.save
      flash[:danger] = "Error when trying to assign the \""+@asset_mission.errors.full_messages.to_sentence
    end
    redirect_to mission_path(@mission)
  end

  def get_mission
    @mission = Mission.find_by(id: params["id"]) || Mission.find_by(id: params["mission_id"])
    if !@mission
      render_404
    end
  end

  def get_asset_mission
    @asset_mission = AssetMission.find_by(id: params["mission_asset_id"])
    if !@asset_mission || @asset_mission.mission != @mission
      render_404
    end
  end

  def mission_params
    params.require(:mission).permit(:project_name, :description, :starting_date, :ending_date)
  end

end
