class Post < ApplicationRecord
  include Postable
  include Statusable

  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]

  # Counter cache to count and save views directly
  is_impressionable counter_cache: true, column_name: :views

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :description, :content
  validates :title, length: { minimum: 2 }
  validates :description, length: { maximum: 450 }
  validates :content, length: { in: 6..5000 }

  after_commit :send_token_for_verification, on: :create

  def send_token_for_verification
    Authy::API.request_sms(id: user.authy_id)
  end
end
