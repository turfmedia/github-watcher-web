class SavedResultsController < ApplicationController

  #create saved result
  def create
    # getting data from cache according search_items_id
    SavedResult.where(repo_id: params[:repo_id], project_id: params[:project_id]).first_or_create(repo_params)
    render :json => {:status => 200}
  end

  def destroy
    SavedResult.where(repo_id: params[:repo_id], project_id: params[:project_id]).first.destroy
    render :json => {:status => 200}
  end

  private

  def repo_params
    params.permit(:repo_title, :repo_description, :repo_url, :repo_stars, :issues, :pushed_at, :search_items_id, :project_id, :repo_id )
  end

end
