class FeedsController < ApplicationController

  def new
    # things will go here eventually
    # but for now, feed urls will be created from the main page
  end

  def create
    feed = current_user.feeds.create(feed_params)
    if feed
      # TODO put a flash notification in here
      feed.reload
      redirect_to root_url
    else
      # TODO put an error message in here
      render :new
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:url)
  end
end
