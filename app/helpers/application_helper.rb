module ApplicationHelper
  STATUS_LABELS = { drafted: 'default', published: 'info', hidden: 'warning' }.freeze

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
    # Check if current user is a passed object owner
    return false unless user_signed_in?
    object.try(:user) == current_user
  end

  def genders
    GENDERS.map { |gender, id| [gender.capitalize, id] }
  end

  def status_label(status)
    return STATUS_LABELS[status] if STATUS_LABELS.include?(status)
  end
end
