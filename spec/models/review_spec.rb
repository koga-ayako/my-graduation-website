require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      review = build(:review)
      expect(review).to be_valid
    end

    it 'is invalid without a content' do
      review = build(:review, content: nil)
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include("を入力してください")
    end

    it 'is invalid without a rating' do
      review = build(:review, rating: nil)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("を入力してください")
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      association = Review.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to shop' do
      association = Review.reflect_on_association(:shop)
      expect(association.macro).to eq :belongs_to
    end
  end
end