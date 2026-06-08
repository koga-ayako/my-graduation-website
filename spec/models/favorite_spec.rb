require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    it 'is invalid with a duplicate user_id and shop_id combination' do
      favorite = create(:favorite)
      duplicate_favorite = build(:favorite, user: favorite.user, shop: favorite.shop)
      expect(duplicate_favorite).not_to be_valid
      expect(duplicate_favorite.errors[:user_id]).to include("はすでに存在します")
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      association = Favorite.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to shop' do
      association = Favorite.reflect_on_association(:shop)
      expect(association.macro).to eq :belongs_to
    end
  end
end