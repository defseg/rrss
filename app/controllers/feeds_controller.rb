class FeedsController < ApplicationController

  before_action :require_login
  before_action :require_own, except: [:reload_all, :index, :create]

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

  def index
    @entries = Entry.joins("INNER JOIN feeds ON entries.feed_id = feeds.id")
                    .joins("INNER JOIN users ON feeds.user_id = users.id")
                    .where(users: {id: current_user.id})
                    .order("entries.pub_date DESC")
                    .includes(:feed)
                    .page(params[:page] || 1)

    # TODO optimize this
    @feeds = current_user.feeds

    render :index
  end

  def reload_all
    feeds = current_user.feeds
    feeds.each { |feed| feed.reload }
    redirect_to root_url
  end

  def reload
    @feed = Feed.find(params[:id])
    @feed.reload
    redirect_to feed_url(@feed)
  end

  def show
    @feeds = current_user.feeds # need this for the sidebar
    @feed = Feed.find(params[:id])
    @entries = @feed.entries.order("pub_date DESC")
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

  def require_login
    redirect_to splash_url unless current_user
  end

  def require_own
    redirect_to root_url unless Feed.find(params[:id]).user_id == current_user.id
  end

end
