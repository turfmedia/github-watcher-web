class SearchItemsController < ApplicationController


	def create
	    @project = Project.find(params[:project_id])
	    @search = @project.search_items.new(search_params)
	    respond_to do |format|
		    if @search.save
		    	format.html { redirect_to project_path(@project), notice: 'Topic was successfully created.' }
		        format.json { render :show, status: :created, location: project_path(@project) }
		    else
	        	format.html { redirect_to project_path(@project), alert: 'Failed to create topic, you must insert minimal 5 character for topic.' }
		    end
		end
	end

	private

	def search_params
		params.require(:search_item).permit(:topic, :language, :project_id) 
	end

end
