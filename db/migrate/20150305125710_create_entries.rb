class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :feed_id

      t.string :title
      t.string :link
      t.string :description
      t.datetime :pubDate
      t.string :content_encoded
      t.string :category
      t.string :dc_creator
      t.string :guid

      t.timestamps
    end
  end
end
