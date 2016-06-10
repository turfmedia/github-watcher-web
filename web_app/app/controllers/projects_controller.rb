class ProjectsController < ApplicationController

	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all
	end


	def show
		@search_items = @project.search_items.order('created_at DESC')
		github_get_repos
		@saved_results_by_project = @project.saved_results.order('created_at DESC')
		@deleted_results_by_project = @project.deleted_results.order('created_at DESC')
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
		    format.html { redirect_to new_project_path, alert: 'Failed to create project, you must insert minimal 5 character for project.' }
		    format.json { render json: @project, alert: 'Failed to create project, you must insert minimal 5 character for project.' }
		  end
		end
	end

	#show readme
  def show_readme
    begin
    	repo_url    = params[:cache_href]
      # request to repo for get readme link/url
      get_readme  =  Octokit.readme(repo_url.split('https://github.com/').last)
      @url_readme = get_readme[:html_url]   	
    	
    	render json: {readme_url: @url_readme, status: 200}
    rescue Exception => e
    	flash[:error] = 'Rate limit/to many request. Please wait.'
    end
  end

	private

	def search_params
		params.require(:search).permit(:topic, :language, :project_id) 
	end


	private

	def set_project
		if params[:project_id].blank?
	  	@project = Project.find(params[:id])
	  else
	  	@project = Project.find(params[:project_id])
	  end
	end

	def project_params
	  params.require(:project).permit(:name, :user_id)
	end
end
