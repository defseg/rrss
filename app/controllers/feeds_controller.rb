class FeedsController < ApplicationController

  def new
  end

  def create
    feed = current_user.feeds.create(feed_params)
    if feed
      # TODO put a flash notification in here
      redirect_to "static_pages#home"
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
