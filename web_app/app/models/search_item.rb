class SearchItem < ActiveRecord::Base
	
	validates :topic, presence: true, length: { minimum:5 }
	
	belongs_to :project

end
