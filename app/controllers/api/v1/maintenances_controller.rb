class Api::V1::MaintenancesController < ApplicationController
  def index
    maintenances = Maintenance.all
    render json: maintenances, status: 200
  end

  def create
    maintenance = Maintenance.new(maintenance_params)

    if maintenance.save
      render json: maintenance, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    maintenance = Maintenance.find_by(id: params[:id])
    if maintenance
      render json: maintenance, status: 200
    else
      render json: { error: "Project not found!" }, status: 404
    end
  end

  def update
    maintenance = Maintenance.find_by(id: params[:id])

    if maintenance
      if maintenance.update(maintenance_params)
        render json: { message: "Project updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  def destroy
    maintenance = Maintenance.find_by(id: params[:id])
    if maintenance
      maintenance.destroy
      render json: { message: "Project deleted successfully" }, status: 200
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  private

  def maintenance_params
    params.require(:maintenance).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end

