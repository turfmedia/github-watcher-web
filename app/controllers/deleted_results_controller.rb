class DeletedResultsController < ApplicationController

  #create deleted results
  def create
    # getting data from cache according search_items_id
    # select_caches_search = SearchItem.get_cache_results(params[:search_items_id]).select {|ca| ca[:id] ==  params[:caches_search_ids].to_i }

    # unless select_caches_search.blank?
    #   project = SearchItem.find(params[:search_items_id]).project
    #   check_insaved_result = SavedResult.find_by(repo_id: select_caches_search.first[:id])
    #   DeletedResult.create_object(project, select_caches_search, params[:search_items_id])

    #   unless check_insaved_result.blank?
    #     check_insaved_result.destroy!
    #   end
    # end

    DeletedResult.create(project_id: params[:projectId], repo_id: params[:repoId])
    render :json => {:status => 200}

  end

end