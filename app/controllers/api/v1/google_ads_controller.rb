class Api::V1::GoogleAdsController < ApplicationController
  def index
    google_ads = GoogleAd.all
    render json: google_ads, status: 200
  end

  def create
    google_ad = GoogleAd.new(google_ad_params)

    if google_ad.save
      render json: google_ad, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    google_ad = GoogleAd.find_by(id: params[:id])
    if google_ad
      render json: google_ad, status: 200
    else
      render json: { error: "Google Ad not found!" }, status: 404
    end
  end

  def update
    google_ad = GoogleAd.find_by(id: params[:id])

    if google_ad
      if google_ad.update(google_ad_params)
        render json: { message: "Google Ad updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Google Ad not found" }, status: 404
    end
  end

  def destroy
    google_ad = GoogleAd.find_by(id: params[:id])
    if google_ad
      google_ad.destroy
      render json: { message: "Google Ad deleted successfully" }, status: 200
    else
      render json: { error: "Google Ad not found" }, status: 404
    end
  end

  private

  def google_ad_params
    params.require(:google_ad).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end
