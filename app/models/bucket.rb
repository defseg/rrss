class Bucket < ActiveRecord::Base
	belongs_to :user
	has_many :bucketings
	has_many :feeds, through: :bucketings
	
end
