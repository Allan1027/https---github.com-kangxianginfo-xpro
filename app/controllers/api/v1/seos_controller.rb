class Api::V1::SeosController < ApplicationController
  def index
    seos = Seo.all
    render json: seos, status: 200
  end

  def create
    seo = Seo.new(seo_params)

    if seo.save
      render json: seo, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    seo = Seo.find_by(id: params[:id])
    if seo
      render json: seo, status: 200
    else
      render json: { error: "Project not found!" }, status: 404
    end
  end

  def update
    seo = Seo.find_by(id: params[:id])

    if seo
      if seo.update(seo_params)
        render json: { message: "Project updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  def destroy
    seo = Seo.find_by(id: params[:id])
    if seo
      seo.destroy
      render json: { message: "Project deleted successfully" }, status: 200
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  private

  def seo_params
    params.require(:seo).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end
