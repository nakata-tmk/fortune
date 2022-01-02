# frozen_string_literal: true

require 'rails_helper'

describe 'Favoriteコントローラーのテスト' do
  let!(:word) { create(:word) }

  context 'いいねをクリックした場合' do
    before do
      visit word_path(word)
    end
    it 'いいねを押す' do
      Favorite.create(word_id: word.id)
      expect(word.favorites.count).to eq 1
    end
  end
end