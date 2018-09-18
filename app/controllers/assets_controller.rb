class AssetsController < ApplicationController
  before_action :must_be_logged, only: [:new, :create, :update]
  before_action :get_asset_type, only: [:create]
  before_action :get_asset,      only: [:show, :update]

  def index
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
    @asset_types = AssetType.all
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_logged_user
    @asset.asset_type = @asset_type
    if @asset.save
      redirect_to assets_path(@asset.id)
    else
      flash[:danger] =  "Failed to create "+@asset.product_serial.upcase+"."+@asset.errors.full_messages.to_sentence
      redirect_to new_asset_path
    end
  end

  def show
    @asset_types = AssetType.all
    @missions = @asset.missions
  end

  def update
    if @asset.update(asset_params)
      flash[:success] = "Asset successfully updated."
      redirect_to asset_path(@asset)
    else
      flash[:danger] =  "Failed to update "+@asset.product_serial.upcase
      redirect_to asset_path(@asset)
    end
  end

  def get_asset
    @asset = Asset.find_by(id: params["id"])
  end

  def get_asset_type
    @asset_type = AssetType.find_by(id: asset_params["asset_type_id"])
  end

  def asset_params
    params.require(:asset).permit(:product_serial, :description, :battery_life, :date_purchase, :asset_type_id, :user_id)
  end

end
