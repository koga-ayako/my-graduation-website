require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      # パスワードがnilの場合、複数のバリデーションエラーが発生する
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end

    it 'is invalid with a password less than 8 characters' do
      user = build(:user, password: 'abc123', password_confirmation: 'abc123')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end

    it 'is invalid with a password without letters and numbers' do
      user = build(:user, password: 'abcdefgh', password_confirmation: 'abcdefgh')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("は英字と数字の両方を含めてください")
    end
  end

  describe 'associations' do
    it 'has many reviews' do
      association = User.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many favorites' do
      association = User.reflect_on_association(:favorites)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end