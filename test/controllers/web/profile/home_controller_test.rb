# frozen_string_literal: true

require 'test_helper'

class Web::Profile::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)
  end

  test '#index' do
    get profile_root_path
    assert_response :success
  end
end
