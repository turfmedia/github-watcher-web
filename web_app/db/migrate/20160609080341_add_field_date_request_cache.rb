class AddFieldDateRequestCache < ActiveRecord::Migration
  def change
    add_column :search_items, :date_request_cache, :datetime
  end
end
