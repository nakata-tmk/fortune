# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Wordモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { word.valid? }
    let!(:word) { build(:word) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        word.body = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は〇' do
        word.body = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        word.body = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Word.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Word.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end