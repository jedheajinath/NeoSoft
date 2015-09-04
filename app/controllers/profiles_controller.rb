class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
  end

  # GET /profiles/new
  def new
    @profile = current_user.build_profile
    @assets = @profile.assets.build
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_params) 
    respond_to do |format|
      if @profile.save 
        params[:profile_assets]['image_name'].each do |a|
          @assets = @profile.assets.create!(image_name: a)
        end
        format.html { redirect_to @profile, notice: 'profile was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end

  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'Profile was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.require(:profile).permit(:name, :contact, :user_id,
      :assets_attributes => [:image_name, :assetable_id, :assetable_type])
  end
end
