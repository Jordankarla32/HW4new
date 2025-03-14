class User < ApplicationRecord
  has_secure_password
  has_many :entries, dependent: :destroy
end
