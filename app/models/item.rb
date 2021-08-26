class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_period

  with_options presence: true do
    validates :image, :name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id, :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_period_id
  end

  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width number' }
  # ⭕️only_integer: true は全角数字を弾く役割もある(おそらく、数字かどうかを判断するnumericalityの働きも加わっている)
end

# ⭕️validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width number' }
# テーブルにinteger型を指定したことと、ActiveRecordの働きの関係で、上記の記述だと半角数字で入力された部分にのみバリデーションがかかり、DBに保存されてしまう
# 全て全角数字で入力した場合は、0に置き換えて保存される仕組み。
