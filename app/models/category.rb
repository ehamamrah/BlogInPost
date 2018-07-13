class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  has_many :posts

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }

  before_destroy :check_associations_with_posts

  scope :active,    (-> { where(status: CATEGORIES_STATUS[:active]) })
  scope :inactive,  (-> { where(status: CATEGORIES_STATUS[:inactive]) })

  def active?
    status == CATEGORIES_STATUS[:active]
  end

  def inactive?
    status == CATEGORIES_STATUS[:inactive]
  end

  def archived?
    status == CATEGORIES_STATUS[:archived]
  end

  private

  def check_associations_with_posts
    return unless posts.present?
    throw(:abort)
  end
end
