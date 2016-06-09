class DeletedResult < ActiveRecord::Base
	belongs_to :project

	#create Deleted Result Object
	def self.create_object(project, select_caches_search, search_items_id)
		DeletedResult.create(
            project_id:      project.id,
            repo_id:         select_caches_search.first[:id],
            repo_title:      select_caches_search.first[:name],
            repo_url:        select_caches_search.first[:url],
            repo_description:select_caches_search.first[:description],
            repo_stars:      select_caches_search.first[:stars],
            search_items_id: search_items_id.to_i
          )
	end
end
