# Article Model
# Relates to: Comments Model
class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title,
            presence: true,
            length: { minimum: 5 }

  validates :text,
            presence: true,
            length: { minimum: 50 }
end
