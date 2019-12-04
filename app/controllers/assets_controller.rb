class AssetsController < ApplicationController
  before_action :must_be_logged, only: [:new, :create, :update, :destroy, :replace_battery]
  before_action :must_be_proprietary, only: [:update, :replace_battery]
  before_action :get_asset_type, only: [:create]
  before_action :get_asset,      only: [:show, :update, :replace_battery]

  add_breadcrumb "assets", :assets_path

  def index
    @assets = Asset.all
  end

  def new
    add_breadcrumb "new asset"
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
    add_breadcrumb @asset.product_serial, asset_path(@asset)
    @asset_types = AssetType.all
    @battery_replacements = @asset.battery_replacements.order('created_at desc').limit(10)
    @missions = @asset.missions.order('starting_date desc', 'ending_date desc')
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

  def destroy
    @asset = Asset.find(params[:id])
    if @asset.destroy
      flash[:success] = "Asset removed"
      redirect_to assets_path()
    else
      flash[:danger] = "Failed to remove asset "+@asset.name
      redirect_to asset_path(@asset_type) # todo: is this really neaded ?
    end
  end

  def replace_battery
    if @asset.battery_life
      @battery_replacement = BatteryReplacement.new(:asset=>@asset, :user=>current_logged_user)
      if @battery_replacement.save
        flash[:success] = "Battery changed successfully."
        redirect_to asset_path(@asset)
      else
        flash[:danger] =  "Failed to change the battery"
        redirect_to asset_path(@asset)
      end
    else
      flash[:warning] =  "This asset has no battery, you can't replace it ;)"
      redirect_to asset_path(@asset)
    end
  end

  def get_asset
    @asset = Asset.find_by(id: params["id"]) || Asset.find_by(id: params["asset_id"])
    if !@asset
      render_404
    end
  end

  def get_asset_type
    @asset_type = AssetType.find_by(id: asset_params["asset_type_id"])
    if !@asset_type
      render_404
    end
  end

  def must_be_proprietary
    self.get_asset
    if @asset.user != current_logged_user
      render_403
    end
  end

  def asset_params
    params.require(:asset).permit(:product_serial, :description, :battery_life, :date_purchase, :asset_type_id, :user_id)
  end

end
