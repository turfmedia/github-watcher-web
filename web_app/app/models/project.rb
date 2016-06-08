class Project < ActiveRecord::Base
	
	validates :name, presence: true, length: { minimum:5 }

	has_many :search_items
	has_many :saved_results
	has_many :deleted_results


	belongs_to :user

end
