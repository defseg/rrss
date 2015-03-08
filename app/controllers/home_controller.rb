class HomeController < ApplicationController

  before_action :require_login, only: :index

  def index
    @feeds = current_user.feeds.includes(:entries)
    render :index
  end

  def splash
  end

  private

  def require_login
    redirect_to :splash unless current_user
  end
end
