class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  validate :empty_category?, on: :destroy

  scope :active,    (-> { where(status: CATEGORIES_STATUS[:active]) })
  scope :inactive,  (-> { where(status: CATEGORIES_STATUS[:inactive]) })

  private

  def empty_category?
    errors.add(:base, I18n.t(:cannot_remove_category_associated_with_posts)) if posts.present?
  end
end
