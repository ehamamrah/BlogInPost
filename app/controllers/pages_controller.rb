class PagesController < ApplicationController
  def home
    @posts       = Post.published
    @most_viewed = Post.published.order_by_views.limit(30)
  end
end
