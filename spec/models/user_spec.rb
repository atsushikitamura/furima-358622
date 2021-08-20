require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、family_name、first_name、family_name_reading、first_name_reading、bornが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合であれば登録できる' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'abcde1'
        @user.password_confirmation = 'abcde1'
        expect(@user).to be_valid
      end
      it 'family_name、first_nameが全角ひらがな・カタカナ・漢字のいずれかであれば登録できる' do
        @user.family_name = 'あア愛'
        @user.first_name = 'あア愛'
        expect(@user).to be_valid
      end
      it 'family_name_reading、first_name_readingが全角カタカナであれば登録できる' do
        @user.family_name_reading = 'アアア'
        @user.first_name_reading = 'アアア'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailが@を含まない場合登録できない' do
        @user.email = 'agmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = 'aaaaa2'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが全角だと登録できない' do
        @user.password = '１２３４５w'
        @user.password_confirmation = '１２３４５w'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric')
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric')
      end
      it 'passwordが半角数字のみだと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric')
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'family_name、firast_nameが半角カタカナだと登録できない' do # 半角ひらがな・漢字は存在しない
        @user.family_name = 'ｱ'
        @user.first_name = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid. Input full-width characters')
      end
      it 'family_name、firast_nameが英字だと登録できない' do
        @user.family_name = 'a'
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid. Input full-width characters')
      end
      it 'family_name_readingが空では登録できない' do
        @user.family_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading can't be blank")
      end
      it 'first_name_readingが空では登録できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'family_name_reading、first_name_readingが半角カタカナだと登録できない' do
        @user.family_name_reading = 'ｱ'
        @user.first_name_reading = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name reading is invalid. Input full-width katakana')
      end
      it 'family_name_reading、first_name_readingがひらがなだと登録できない' do
        @user.family_name_reading = 'あ'
        @user.first_name_reading = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name reading is invalid. Input full-width katakana')
      end
      it 'family_name_reading、first_name_readingが漢字だと登録できない' do
        @user.family_name_reading = '愛'
        @user.first_name_reading = '愛'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name reading is invalid. Input full-width katakana')
      end
      it 'family_name_reading、first_name_readingが英字だと登録できない' do
        @user.family_name_reading = 'a'
        @user.first_name_reading = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name reading is invalid. Input full-width katakana')
      end
      it 'bornが空では登録できない' do
        @user.born = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Born can't be blank")
      end
    end
  end
end
