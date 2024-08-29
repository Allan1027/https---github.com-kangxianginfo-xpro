class Api::V1::GraphicDesignsController < ApplicationController
  def index
    graphic_designs = GraphicDesign.all
    render json: graphic_designs, status: 200
  end

  def create
    graphic_design = GraphicDesign.new(graphic_design_params)

    if graphic_design.save
      render json: graphic_design, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    graphic_design = GraphicDesign.find_by(id: params[:id])
    if graphic_design
      render json: graphic_design, status: 200
    else
      render json: { error: "Graphic Design not found!" }, status: 404
    end
  end

  def update
    graphic_design = GraphicDesign.find_by(id: params[:id])

    if graphic_design
      if graphic_design.update(graphic_design_params)
        render json: { message: "Graphic Design updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Graphic Design not found" }, status: 404
    end
  end

  def destroy
    graphic_design = GraphicDesign.find_by(id: params[:id])
    if graphic_design
      graphic_design.destroy
      render json: { message: "Graphic Design deleted successfully" }, status: 200
    else
      render json: { error: "Graphic Design not found" }, status: 404
    end
  end

  private

  def graphic_design_params
    params.require(:graphic_design).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end
