class AssetTypesController < ApplicationController

  def index
    @asset_types = AssetType.all
  end

  def new
    @assettype = AssetType.new
  end

  def create
    @asset_type = AssetType.new(asset_type_params)
    if @asset_type.save
      redirect_to asset_types_path(@asset_type.id)
    else
      flash.now[:danger] =  "Failed to create "+@asset_type.name
      render 'new'
    end
  end

  def asset_type_params
    params.require(:asset_type).permit(:name, :description)
  end
end
