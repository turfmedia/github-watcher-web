class RenameSearchTableToSearchItemTable < ActiveRecord::Migration
  def change
  	rename_table :searches, :search_items
  end
end
