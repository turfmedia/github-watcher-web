class DeletedResultsController < ApplicationController

  #create deleted results
  def create
    begin
      # getting data from cache according search_items_id
      caches_search = CACHESEARCH.get("search_"+params[:search_items_id].to_s)
      select_caches_search = caches_search.select {|ca| ca[:id] ==  params[:caches_search_ids].to_i }
      unless select_caches_search.blank?
        project = SearchItem.find(params[:search_items_id]).project
        check_insaved_result = SavedResult.find_by(repo_id: select_caches_search.first[:id])
        DeletedResult.create(
            project_id:      project.id,
            repo_id:         select_caches_search.first[:id],
            repo_title:      select_caches_search.first[:name],
            repo_url:        select_caches_search.first[:url],
            repo_description:select_caches_search.first[:description],
            repo_stars:      select_caches_search.first[:stars],
            search_items_id: params[:search_items_id].to_i
          )
        unless check_insaved_result.blank?
          check_insaved_result.destroy!
        end
      end

      render :json => {:status => 200}
      # redirect_to project_search_item_path(project.id, params[:search_items_id].to_i)
    rescue Exception => e
    end
  end

end