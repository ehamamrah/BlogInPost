module Statusable
  extend ActiveSupport::Concern

  def active?
    status == CATEGORIES_STATUS[:active]
  end

  def inactive?
    status == CATEGORIES_STATUS[:inactive]
  end

  def archived?
    status == CATEGORIES_STATUS[:archived]
  end

  def published?
    status == POST_STATUS[:published]
  end

  def drafted?
    status == POST_STATUS[:drafted]
  end

  def hidden?
    status == POST_STATUS[:hidden]
  end
end
