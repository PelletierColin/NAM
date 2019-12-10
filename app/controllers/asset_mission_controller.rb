class AssetMissionController < ApplicationController
  before_action :get_asset_mission, only: [:show, :update]

  before_action do
    add_breadcrumb 'missions', :missions_path
    add_breadcrumb @asset_mission.mission.project_name, mission_path(@asset_mission.mission)
  end

  def show
    add_breadcrumb 'asset ' + @asset_mission.asset.product_serial
  end

  def update
    if @asset_mission.update(asset_mission_params)
      flash[:success] = 'Asset mission successfully updated.'
      redirect_to mission_path(@asset_mission.mission_id)
    else
      flash[:danger] = 'Failed to update asset mission.'
      redirect_to mission_asset_mission_path(@asset_mission.mission, @asset_mission)
    end
  end

  def get_asset_mission
    @asset_mission = AssetMission.find_by(id: params['id'])
    if !@asset_mission
      render_404
    end
  end

  def asset_mission_params
    params.require(:asset_mission).permit(:placement_indications, :created_at, :extracted_at)
  end
end
