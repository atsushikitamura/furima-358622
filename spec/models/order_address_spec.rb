require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1 # インスタンスを生成する処理を0.1秒待機。テストに負荷がかかりすぎて、読み込み時間以内に処理が終わらず、エラーになることがあるらしい。
  end

  describe '商品購入機能' do
    context '商品を購入できる場合' do
      it 'token、postal_code、prefecture_id、city、house_number、building_name、phone_number、user_id、item_idが存在していれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
      it 'postal_codeが「半角数字3文字+ハイフン+半角数字4文字」の形式であれば購入できる' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end
      it 'phone_numberが10文字以上11文字以下の半角数字であれば購入できる' do
        @order_address.phone_number = '0123456789'
        expect(@order_address).to be_valid
      end
    end

    context '商品を購入できない場合' do
      it 'tokenが空では購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが全角だと購入できない' do
        @order_address.postal_code = '１２３ー４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeにハイフンが含まれない場合購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeが3文字+4文字でないと購入できない' do
        @order_address.postal_code = '12-34567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが1では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9文字以下だと購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_numberが全角だと購入できない' do
        @order_address.phone_number = '０１２３４５６７８９'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'user_idが空では購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
