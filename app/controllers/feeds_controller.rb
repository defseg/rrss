class FeedsController < ApplicationController

  def new
    # things will go here eventually
    # but for now, feed urls will be created from the main page
  end

  def create
    feed = current_user.feeds.new(feed_params)
    # TODO allow custom titles?
    feed.title = feed.get_title

    if feed.save
      # TODO put a flash notification in here
      feed.reload
      redirect_to root_url
    else
      # TODO put an error message in here
      render :new
    end
  end

  def reload_all
    feeds = Feed.where(id: current_user.id)
    feeds.each { |feed| feed.reload }
    puts feeds
    redirect_to root_url
  end

  def reload
    @feed = Feed.find(params[:id])
    @feed.reload
    redirect_to feed_url(@feed)
  end

  def show
    @feed = Feed.find(params[:id])
    render :show
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    flash[:notice] = "Feed deleted"
    redirect_to root_url
  end

  private

  def feed_params
    params.require(:feed).permit(:url)
  end
end
