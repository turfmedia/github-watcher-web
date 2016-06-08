class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper method to define object user
  helper_method :current_user
 
  #request to github to get repos based on search fields
  def github_get_repos
    if params[:controller] == 'projects'
      @search = @project.search_items.first
    elsif params[:controller] == 'search_items'
      @search = @search_item
    end
    caches_search = CACHESEARCH.get("search_"+@search.id.to_s)
    @caches_search = if caches_search.blank?
      user_token = current_user.token
      topic      = @search.topic
      language   = @search.language
      client_initialize = Github::Watcher::Client.new(user_token)
      new_search = client_initialize.search(topic, language)

      CACHESEARCH.set("search_"+@search.id.to_s, new_search, 1.day)
      caches_search = CACHESEARCH.get("search_"+@search.id.to_s)
    else
      caches_search
    end
  end

  private
 
  #find a user with user session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
