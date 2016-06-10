class User < ActiveRecord::Base
  
  validates_presence_of :uid, :email, :token

  has_many :projects
 
  #creating a new user based on github callback auth
  def self.create_with_omniauth(auth=OmniAuth::AuthHash.new)
    if auth.class.eql?(OmniAuth::AuthHash)
        user = User.new
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.token = auth["credentials"]["token"] if auth["credentials"]
        user.username = auth["info"]["nickname"] if auth["info"]
        user.name = auth["info"]["name"] if auth["info"]
        user.email = auth["info"]["email"] if auth["info"]
        user.save
        user
    else
      nil
    end
  end

end
