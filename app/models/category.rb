class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  has_many :posts, dependent: :destroy
end
