class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_save { email.downcase! }
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: { maximum: 50 }

  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password,
    presence: true,
    length: { minimum: 8 }

  validates :auth0_id,
    length: { maximum: 255 },
    uniqueness: {allow_blank: true}

end
