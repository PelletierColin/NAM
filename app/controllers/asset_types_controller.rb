class AssetTypesController < ApplicationController
  before_action :must_be_logged, only: [:new, :create, :update]
  before_action :get_asset_type, only: [:show, :update]

  def index
    @asset_types = AssetType.all
  end

  def new
    @asset_type = AssetType.new
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

  def show
    @assets = Asset.where(asset_type: @asset_type)
  end

  def update
    if @asset_type.update(asset_type_params)
      flash[:success] = "Asset type successfully updated."
      redirect_to asset_type_path(@asset_type)
    else
      flash[:danger] =  "Failed to update "+@asset_type.name.capitalize
      redirect_to asset_type_path(@asset_type)
    end
  end

  def get_asset_type
    @asset_type = AssetType.find_by(id: params["id"])
    if !@asset_type
      render_404
    end
  end

  def asset_type_params
    params.require(:asset_type).permit(:name, :description)
  end
end
