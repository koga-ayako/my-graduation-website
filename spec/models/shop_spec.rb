require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      shop = build(:shop)
      expect(shop).to be_valid
    end
  end

  describe 'associations' do
    it 'has many reviews' do
      association = Shop.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many favorites' do
      association = Shop.reflect_on_association(:favorites)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end