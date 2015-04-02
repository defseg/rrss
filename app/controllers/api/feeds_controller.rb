class Api::FeedsController < Api::ApiController

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
      render json: :new
    end
  end

  def index
    entries = Entry.joins("INNER JOIN feeds ON entries.feed_id = feeds.id")
                    .joins("INNER JOIN users ON feeds.user_id = users.id")
                    .where(users: {id: current_user.id})
                    .order("entries.pub_date DESC")
                    .includes(:feed)
                    .page(params[:page] || 1)

    render json: entries
  end

  def reload_all
    feeds = current_user.feeds
    feeds.each { |feed| feed.reload }
    render json: feeds
  end

  def reload
    feed = Feed.find(params[:id])
    feed.reload
    render json: feed.entries
  end

  def show
    feed = Feed.find(params[:id])
    entries = feed.entries.order("pub_date DESC")
    render json: entries
  end

  def destroy
    feed = Feed.find(params[:id])
    # TODO make this better
    if feed.destroy
      render json: "Feed deleted"
    else
      render json: "Error"
    end
  end

  # TODO will need something to send up all of a user's feeds
  # for the sidebar

  private

  def feed_params
    params.require(:feed).permit(:url)
  end

  def require_login
    # TODO replace with json error
    redirect_to splash_url unless current_user
  end

  def require_own
    # TODO replace with json error
    redirect_to root_url unless Feed.find(params[:id]).user_id == current_user.id
  end

end
