class SavedResultsController < ApplicationController

  #create saved result
  def create
    # getting data from cache according search_items_id
    SavedResult.create(
      project_id: params[:projectId],
      repo_id: params[:repoId],
      repo_title: params[:repoTitle],
      repo_url: params[:repoUrl],
      repo_description: params[:repoDescription],
    )
    render :json => {:status => 200}
  end

end