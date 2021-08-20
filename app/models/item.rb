class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image, :name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id, :price
  end
  validates :price, numericality: { in: 300..9999999, message: 'is out of setting range' }
  validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width number' }
end