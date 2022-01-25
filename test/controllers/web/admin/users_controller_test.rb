# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in(@user)
  end

  test '#index' do
    get admin_users_path
    assert_response :success
  end

  test '#edit' do
    get edit_admin_user_path @user
    assert_response :success
  end

  test '#update' do
    attrs = FactoryBot.attributes_for :user

    patch admin_user_path @user, params: { user: attrs }
    assert_response :redirect

    @user.reload

    assert @user.name == attrs[:name]
  end

  test '#destroy' do
    user = users(:two)

    delete admin_user_path user

    assert_response :redirect

    assert_raise(ActiveRecord::RecordNotFound) { User.find(user.id) }
  end
end
