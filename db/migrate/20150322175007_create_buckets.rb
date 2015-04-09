class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
    	t.string :name
    	t.integer :user_id, null: false	
    end
    add_index :buckets, [:name, :user_id], unique: true
  end
end
