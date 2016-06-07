class ProjectsController < ApplicationController

	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all
	end


	def show
		@search = SearchItem.new
	end

	def new
		@project = Project.new
	end


	def create
		@project = Project.new(project_params)

		respond_to do |format|
		  if @project.save
		    format.html { redirect_to @project, notice: 'Project was successfully created.' }
		    format.json { render :show, status: :created, location: @project }
		  else
		    format.html { render :new }
		    format.json { render json: @project, alert: 'unprocessable_entity' }
		  end
		end
	end

	private

	def search_params
		params.require(:search).permit(:topic, :language, :project_id) 
	end


	private

	def set_project
	  @project = Project.find(params[:id])
	end

	def project_params
	  params.require(:project).permit(:name, :user_id)
	end
end