class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :topic
      t.string :language

      t.timestamps null: false
    end
  end
end
