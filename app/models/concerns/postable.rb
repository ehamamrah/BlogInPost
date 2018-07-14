module Postable
  extend ActiveSupport::Concern

  included do
    # Post scopes to get posts based on status
    scope :drafted,       (-> { where(status: POST_STATUS[:drafted]) })
    scope :published,     (-> { where(status: POST_STATUS[:published]) })
    scope :hidden,        (-> { where(status: POST_STATUS[:hidden]) })

    # Recent published posts
    scope :recent,        (-> { published.order_by_date.where('created_at BETWEEN ? AND ?', Date.today - 5.days, Date.today) })

    # Arrange posts based ordering
    scope :order_by_date,  (-> { order(created_at: :desc) })
    scope :order_by_views, (-> { published.order(views: :desc) })

    # Get related posts based on category with condition published
    scope :related_posts, (->(category_id) { published.order_by_date.where(category_id: category_id) })
  end

  def publish
    return unless status.in?([POST_STATUS[:drafted], POST_STATUS[:hidden]])
    update_attribute(:status, POST_STATUS[:published])
  end

  def hide
    return unless status.in?([POST_STATUS[:published]])
    update_attribute(:status, POST_STATUS[:hidden])
  end
end
