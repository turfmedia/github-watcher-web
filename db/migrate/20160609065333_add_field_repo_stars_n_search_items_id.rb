class AddFieldRepoStarsNSearchItemsId < ActiveRecord::Migration
  def change
    add_column :saved_results,   :repo_stars,      :integer
    add_column :saved_results,   :search_items_id, :integer
    add_column :deleted_results, :repo_stars,      :integer
    add_column :deleted_results, :search_items_id, :integer
  end
end