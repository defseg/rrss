class BucketsController < ApplicationController

	def new
	end

	def create
		bucket = current_user.buckets.new(bucket_params)
    
    if bucket.save
      # TODO put a flash notification in here
      bucket.reload
      redirect_to root_url
    else
      # TODO put an error message in here
      render :new
    end
	end

	private

	def bucket_params
		params.require(:bucket).permit(:name)
	end

end
