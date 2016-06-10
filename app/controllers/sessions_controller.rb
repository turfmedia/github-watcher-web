class SessionsController < ApplicationController

  #handle/retrive the github callback with auth as a data
  def create
    #github data
    auth = request.env["omniauth.auth"]

    #create a new user if there is no user with github provider and uid or just call the user
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

    session[:user_id] = user.id
    redirect_to projects_user_url(user), :notice => "Signed in!"
  end

  #destroy/logut user session
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
