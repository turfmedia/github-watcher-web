class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper method to define object user
  helper_method :current_user

  #request to github to get repos based on search fields
  def github_get_repos
    unless params[:controller] == 'search_items' && params[:action] == 'create'
      if params[:project_id].blank?
        @search = Project.find(params[:id]).search_items.last
      else
        @search = SearchItem.find(params[:id])
      end
    end
    if params[:project_id].blank?
      @search_items_id = Project.find(params[:id]).search_items.last.try(:id)
    else
      @search_items_id = params[:id]
    end
    @search

  end

  private

  #find a user with user session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
