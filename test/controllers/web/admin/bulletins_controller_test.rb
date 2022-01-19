# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @bulletin = bulletins :one
    sign_in(@user)
  end

  test '#index' do
    get admin_bulletins_path
    assert_response :success
  end

  # test '#approve' do
  #   get approve_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.published?
  # end
  #
  # test '#reject' do
  #   get reject_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.rejected?
  # end
  #
  # test '#archive' do
  #   get archive_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.archived?
  # end
end
