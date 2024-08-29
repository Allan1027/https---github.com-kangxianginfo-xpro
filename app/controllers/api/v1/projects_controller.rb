class Api::V1::ProjectsController < ApplicationController
  def index
    projects = Project.all
    render json: projects, status: 200
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: project, status: 201 # Created
    else
      render json: { error: "Creating error..." }, status: 422 # Unprocessable Entity
    end
  end

  def show
    project = Project.find_by(id: params[:id])
    if project
      render json: project, status: 200
    else
      render json: { error: "Project not found!" }, status: 404
    end
  end

  def update
    project = Project.find_by(id: params[:id])

    if project
      if project.update(project_params)
        render json: { message: "Project updated successfully" }, status: 200
      else
        render json: { error: "Updating error..." }, status: 422
      end
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])
    if project
      project.destroy
      render json: { message: "Project deleted successfully" }, status: 200
    else
      render json: { error: "Project not found" }, status: 404
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :status, :assignee, :priority, :description, :start_date, :end_date)
  end
end
