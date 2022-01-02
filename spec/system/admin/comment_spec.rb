# frozen_string_literal: true

require 'rails_helper'

describe 'Commentコントローラーのテスト' do
  let!(:admin) { create(:admin) }
  let!(:word) { create(:word) }
  let!(:comment) { create(:comment, word_id: word.id) }
  before do
    visit admin_login_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find('input[name="commit"]').click
    visit admin_word_path(word)
  end

  context '削除のテスト' do
    before do
      page.all('a')[4].click
    end
    it '正しく削除される' do
      expect(Comment.where(id: word.id).count).to eq 0
    end
  end
end