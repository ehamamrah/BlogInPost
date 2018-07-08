module ApplicationHelper
  # retrieve active categories only
  def active_categories
    Category.active
  end

  def ownername(object)
    object.user.try(:username) || object.user.email
  end

  def convert_date_format(date)
    date.strftime('%F')
  end

  def statuses
    CATEGORIES_STATUS.map { |status, value| [status.capitalize, value] }
  end
end
