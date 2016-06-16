class AddPushedAtAndIssuesToSavedResult < ActiveRecord::Migration
  def change
    add_column :saved_results,   :pushed_at, :date
    add_column :saved_results,   :issues,    :integer
    add_column :deleted_results, :pushed_at, :date
    add_column :deleted_results, :issues,    :integer
  end
end
