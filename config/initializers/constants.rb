# Posts statuses list
POST_STATUS = {
  drafted: 1,
  published: 2,
  hidden: 3
}.freeze

# list of user roles
ROLES = { user: 'user', superadmin: 'superadmin' }.freeze

# categories statuses with ids
CATEGORIES_STATUS = {
  active: 1,
  inactive: 2,
  archived: 3
}.freeze

GENDERS = { male: 1, female: 2 }.freeze

# a color list for post status labels
STATUS_LABELS = { drafted: 'default', published: 'info', hidden: 'warning' }.freeze

# list of providers name and icons
PROVIDERS = { facebook: { icon: 'facebook-square', name: 'Facebook' },
              google_oauth2: { icon: 'google-plus-square', name: 'Google' } }.freeze
