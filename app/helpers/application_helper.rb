module ApplicationHelper
  STATUS_LABELS = { drafted: 'default', published: 'info', hidden: 'warning' }.freeze
  PROVIDERS = { facebook: { icon: 'facebook-square', name: 'Facebook' },
                google_oauth2: { icon: 'google-plus-square', name: 'Google' } }.freeze

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
    # return genders in array of arrays
    GENDERS.map { |gender, id| [gender.capitalize, id] }
  end

  def status_label(status)
    # Return status label specified color
    return STATUS_LABELS[status] if STATUS_LABELS.include?(status)
  end

  def link_to_provider(provider, resource, controller)
    link_to omniauth_authorize_path(resource, provider) do
      provider_text = controller == 'registrations' ? "#{t(:sign_up_with)}" : "#{t(:sign_in_with)}"
      icon('fab', PROVIDERS[provider][:icon], "#{provider_text} #{PROVIDERS[provider][:name]}")
    end
  end
end
