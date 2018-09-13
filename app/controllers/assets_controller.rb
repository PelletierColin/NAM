class AssetsController < ApplicationController
  before_action :must_be_logged, only:   [:new, :create]
  before_action :get_asset_type, only: [:create]

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
      flash.now[:danger] =  "Failed to create "+@asset.product_serial
      render 'new'
    end
  end

  def get_asset_type
    @asset_type = AssetType.find_by(id: params["asset_type"])
  end

  def asset_params
    params.require(:asset).permit(:product_serial, :description, :battery_life, :date_purchase, :asset_type)
  end

end
