module Postable
  extend ActiveSupport::Concern

  included do
    scope :drafted,   (-> { where(status: POST_STATUS[:drafted]) })
    scope :published, (-> { where(status: POST_STATUS[:published]) })
    scope :hidden,    (-> { where(status: POST_STATUS[:hidden]) })
    scope :recent,    (-> { published.where('created_at BETWEEN ? AND ?', Date.today - 5.days, Date.today) })
  end
end
