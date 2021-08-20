class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_period


  with_options presence: true do
    validates :image, :name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id, :price
  end

  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is out of setting range' }
  validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width number' }
end