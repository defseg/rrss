class HomeController < ApplicationController

  before_action :require_login, only: :index

  def index
    @entries = Entry.joins("INNER JOIN feeds ON entries.feed_id = feeds.id")
                    .joins("INNER JOIN users ON feeds.user_id = users.id")
                    .where(users: {id: current_user.id})
                    .order("entries.updated_at DESC")
                    .includes(:feed)
                    .page(params[:page] || 1)
    render :index
  end

  def splash
  end

  private

  def require_login
    redirect_to :splash unless current_user
  end
end
