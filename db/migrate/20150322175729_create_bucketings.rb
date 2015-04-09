class CreateBucketings < ActiveRecord::Migration
  def change
    create_table :bucketings do |t|
    	t.integer :bucket_id, null: false
    	t.integer :feed_id, null: false
    end
		add_index :bucketings, [:bucket_id, :feed_id], unique: true
  end
end
