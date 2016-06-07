class CreateDeletedResults < ActiveRecord::Migration
  def change
    create_table :deleted_results do |t|
      t.integer :project_id
      t.integer :repo_id
      t.string :repo_title
      t.string :repo_url
      t.string :repo_description

      t.timestamps null: false
    end
  end
end
