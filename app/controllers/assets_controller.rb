class AssetsController < ApplicationController
  before_action :must_be_logged, only:   [:new, :create]

  def index
    @assets = Asset.all
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    @asset.user = current_logged_user
    if @asset.save
      redirect_to assets_path(@asset.id)
    else
      flash.now[:danger] =  "Failed to create "+@asset.product_serial
      render 'new'
    end
  end

  def asset_params
    params.require(:asset).permit(:product_serial, :description, :battery_life, :date_purchase)
  end

end
