class Api::V1::WebsiteDesignsController < ApplicationController
  def index
    website_designs = WebsiteDesign.all
    render json: website_designs, status: 200
  end

  def create
    website_design = WebsiteDesign.new(website_design_params)

    if website_design.save
      render json: website_design, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    website_design = WebsiteDesign.find_by(id: params[:id])
    if website_design
      render json: website_design, status: 200
    else
      render json: { error: "Website Design not found!" }, status: 404
    end
  end

  def update
    website_design = WebsiteDesign.find_by(id: params[:id])

    if website_design
      if website_design.update(website_design_params)
        render json: { message: "Website Design updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Website Design not found" }, status: 404
    end
  end

  def destroy
    website_design = WebsiteDesign.find_by(id: params[:id])
    if website_design
      website_design.destroy
      render json: { message: "Website Design deleted successfully" }, status: 200
    else
      render json: { error: "Website Design not found" }, status: 404
    end
  end

  private

  def website_design_params
    params.require(:website_design).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end
