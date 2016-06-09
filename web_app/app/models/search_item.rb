class SearchItem < ActiveRecord::Base
	
	validates :topic, presence: true, length: { minimum:5 }
	
	belongs_to :project


	def self.get_cache_results(search_items_id)
		CACHESEARCH.get("search_"+search_items_id.to_s)
	end
end
