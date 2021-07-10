class User < ApplicationRecord

    before_save{self.email = email.downcase} # for changing all upcase to downcase.

    has_many :articles, dependent: :destroy # if user is deleted, any article associated with user will also deleted
    validates :username, presence: true, uniqueness: { case_sensitive: false },
                        length: {minimum: 3, maximum: 25}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,uniqueness: { case_sensitive: false },
                        length: {maximum: 105},
                        format: { with: VALID_EMAIL_REGEX }
    has_secure_password 
end