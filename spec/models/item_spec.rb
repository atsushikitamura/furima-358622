require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能(保存)' do
    context '商品情報が保存できる場合' do
      it 'image、name、text、category_id、status_id、delivery_fee_id、prefecture_id、delivery_period_id、price、userが存在すれば保存できる' do
        expect(@item).to be_valid
      end
      it 'category_id、status_id、delivery_fee_id、prefecture_id、delivery_period_idがそれぞれ1以外であれば保存できる' do
        @item.category_id = 7
        @item.status_id = 5
        @item.delivery_fee_id = 3
        @item.prefecture_id = 35
        @item.delivery_period_id = 4
        expect(@item).to be_valid
      end
      it 'priceの値が300~9,999,999の間であれば保存できる' do
        @item.price = 647_382
        expect(@item).to be_valid
      end
      it 'priceが半角数字であれば保存できる' do
        @item.price = 192_836
        expect(@item).to be_valid
      end
    end
    context '商品情報が保存できない場合' do
      it 'imageが紐付いていないと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'textが空だと保存できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'category_idが空だと保存できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが空だと保存できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'delivery_fee_idが空だと保存できない' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end
      it 'prefecture_idが空だと保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'delivery_period_idが空だと保存できない' do
        @item.delivery_period_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery period can't be blank")
      end
      it 'category_id、status_id、delivery_fee_id、prefecture_id、delivery_period_idがそれぞれ1だと保存できない' do
        @item.category_id = 1
        @item.status_id = 1
        @item.delivery_fee_id = 1
        @item.prefecture_id = 1
        @item.delivery_period_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'priceが空だと保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceの値が299以下だと保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceの値が10,000,000以上だと保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceが全角だと保存できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width number')
      end
      it 'priceが数字以外だと登録できない(半角英字・半角カナ)' do
        @item.price = 'aｱ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width number')
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
