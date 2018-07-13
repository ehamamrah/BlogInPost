module ApplicationHelper
  def active_categories
    # retrieve active categories only
    Category.active.map { |category| [category.name, category.id] }
  end

  def ownername(object)
    # Try to retrieve username to use it, otherwise use the email.
    object.user.try(:username) || object.user.email
  end

  def convert_date_format(date)
    # convert date format to show dates withour time.
    date.strftime('%F')
  end

  def statuses
    # get a list of categories statuses
    CATEGORIES_STATUS.map { |status, value| [status.capitalize, value] }
  end

  def find_category(id)
    # Find category by id
    Category.find(id)
  end

  def owner?(object)
    return false unless user_signed_in?
    object.try(:user) == current_user
  end
end
