class Post < ApplicationRecord
  include Postable
  include Statusable

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :description, :content
  validates :title, length: { minimum: 2 }
  validates :description, length: { maximum: 450 }
  validates :content, length: { in: 6..5000 }
end
