class Post < ApplicationRecord
  include Postable

  belongs_to :user

  validates_presence_of :title, :description, :content
  validates :title, length: { minimum: 2 }
  validates :description, length: { maximum: 350 }
  validates :content, length: { in: 6..2500 }
end
