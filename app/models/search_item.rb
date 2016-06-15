class SearchItem < ActiveRecord::Base

  validates :topic, presence: true

  belongs_to :project

  def results
    GithubCached.search(project.user.token, topic, language)
  end

  def self.get_cache_results(search_items_id)
    GithubCached.search(topic, language)
  end
end
