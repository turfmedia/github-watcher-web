class SearchItem < ActiveRecord::Base
	
	validates :topic, presence: true
	
	belongs_to :project


	def self.get_cache_results(search_items_id)
		CACHESEARCH.get("search_"+search_items_id.to_s)
	end
end
