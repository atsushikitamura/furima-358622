class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, :family_name, :first_name, :family_name_reading, :first_name_reading, :born
  end
  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: "is invalid. Input half-width alphanumeric" }
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters" }
  validates :family_name_reading, :first_name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana" }
end
