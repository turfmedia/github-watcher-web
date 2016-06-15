class SavedResult < ActiveRecord::Base
  belongs_to :project

  def reference
    repo_url.split('github.com/')[1]
  end
end
