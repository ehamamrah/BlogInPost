class Post < ApplicationRecord
  include Postable
  include Statusable

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  # Counter cache to count and save views directly
  is_impressionable counter_cache: true, column_name: :views

  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 2 }
  validates :description, length: { maximum: 450 }
  validates :content, length: { in: 6..5000 }

  validates_presence_of :title, :description, :content
end
