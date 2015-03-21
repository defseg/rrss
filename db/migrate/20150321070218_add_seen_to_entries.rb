class AddSeenToEntries < ActiveRecord::Migration
  def change
  	add_column :entries, :seen, :boolean, null: false, default: false
  end
end
