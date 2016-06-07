class AddProjectIdToSearchItems < ActiveRecord::Migration
  def change
  	add_column :search_items, :project_id, :integer
  end
end
