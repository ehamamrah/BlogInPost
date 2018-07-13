module Postable
  extend ActiveSupport::Concern

  included do
    scope :drafted,       (-> { where(status: POST_STATUS[:drafted]) })
    scope :published,     (-> { where(status: POST_STATUS[:published]) })
    scope :hidden,        (-> { where(status: POST_STATUS[:hidden]) })
    scope :recent,        (-> { published.where('created_at BETWEEN ? AND ?', Date.today - 5.days, Date.today) })
    scope :order_by_date, (-> { order(created_at: :desc) })
    scope :related_posts, (->(category_id) { order_by_date.where(category_id: category_id) })
  end
end
