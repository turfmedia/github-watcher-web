class SearchItemsController < ApplicationController
  before_action :find_search_item, only:[:show]

  #create search item
  def create
    @project = Project.find(params[:project_id])
    @search_item = @project.search_items.where(search_params).first_or_initialize
    respond_to do |format|
      if @search_item.save
        github_get_repos
        format.html { redirect_to project_search_item_path(@project.id, @search_item.id), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: project_path(@project) }
      else
         format.html { redirect_to project_path(@project), alert: 'Failed to create topic, you must insert minimal 5 character for topic.' }
      end
    end
  end

  #show search item
  def show
    @search_items_id = params[:id]
    @search = SearchItem.find(params[:id])
    if params[:project_id].blank?
      @search_items_id = Project.find(params[:id]).search_items.last.id
    else

    end

  end

  private
  #find search item by id
  def find_search_item
    @search_item = SearchItem.find(params[:id])
  end

  #params search item(fields of search items)
  def search_params
    params.require(:search_item).permit(:topic, :language, :project_id)
  end

end
