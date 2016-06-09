class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper method to define object user
  helper_method :current_user
 
  #request to github to get repos based on search fields
  def github_get_repos
    begin
      unless params[:controller] == 'search_items' && params[:action] == 'create'
        if params[:project_id].blank?
          @search = Project.find(params[:id]).search_items.last
        else
          @search = SearchItem.find(params[:id])
        end
      end
      
      # getting data from cache
      caches_search = CACHESEARCH.get("search_"+@search.id.to_s)
      @caches_search = if caches_search.blank?
        user_token = current_user.token
        topic      = @search.topic
        language   = @search.language
        @search.update(date_request_cache: Time.now)
        client_initialize = Github::Watcher::Client.new(user_token)
        new_search = client_initialize.search(topic, language)

        # storing data to cache and set time out to delete data in one day
        CACHESEARCH.set("search_"+@search.id.to_s, new_search, 1.day)
        caches_search = CACHESEARCH.get("search_"+@search.id.to_s)
      else
        caches_search
      end
    rescue Exception => e
    end
  end

  private
 
  #find a user with user session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
