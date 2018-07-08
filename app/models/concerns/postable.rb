module Requestable
  extend ActiveSupport::Concern

  included do
    scope :drafted,      (-> { where(status: POST_STATUS[:drafted]) })
    scope :published,    (-> { where(status: POST_STATUS[:published]) })
    scope :hidden,       (-> { where(status: POST_STATUS[:hidden]) })
  end
end
