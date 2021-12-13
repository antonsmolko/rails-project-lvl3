# frozen_string_literal: true

require_relative '../application_system_test_case'

class HomeTest < ApplicationSystemTestCase

  test 'visiting to Home' do
    visit root_url
    assert_selector 'h1', text: t('home.index.title')
  end

  test 'searching a Bulletin by name' do
    visit root_url

    fill_in 'q_name_cont', with: 'one'
    submit

    assert_text 'Test One Bulletin Name'
  end
end
