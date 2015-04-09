class Bucketing < ActiveRecord::Base
	belongs_to :bucket 
	belongs_to :feed
end
