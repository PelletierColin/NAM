class AssetTypesController < ApplicationController
  before_action :must_be_logged, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_asset_type, only: [:show, :edit, :update]

  add_breadcrumb "asset types", :asset_types_path

  def index
    @asset_types = AssetType.all
  end

  def new
    add_breadcrumb "new asset type"
    @asset_type = AssetType.new
  end

  def create
    @asset_type = AssetType.new(asset_type_params)
    if @asset_type.save
      flash[:success] = "Asset type successfully created."
      redirect_to asset_type_path(@asset_type)
    else
      flash.now[:danger] = "Failed to create "+@asset_type.name
      render 'new'
    end
  end

  def show
    add_breadcrumb @asset_type.name, asset_type_path(@asset_type)
    @assets = Asset.where(asset_type: @asset_type, deleted: false)
  end

  def edit
    add_breadcrumb @asset_type.name, asset_type_path(@asset_type)
    add_breadcrumb 'edit'
  end

  def update
    add_breadcrumb @asset_type.name, asset_type_path(@asset_type)
    add_breadcrumb 'edit'

    if @asset_type.update(asset_type_params)
      flash[:success] = "Asset type successfully updated."
      redirect_to asset_type_path(@asset_type)
    else
      render 'edit'
    end
  end

  def destroy
    @asset_type = AssetType.find(params[:id])
    if @asset_type.destroy
      flash[:success] = "Asset type removed"
      redirect_to asset_types_path
    else
      flash[:danger] = "Failed to remove "+@asset_type.name
      redirect_to asset_type_path(@asset_type) # todo: is this really neaded ?
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
