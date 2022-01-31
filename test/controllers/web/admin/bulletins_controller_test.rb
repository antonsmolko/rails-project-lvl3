# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)
    @bulletin = bulletins :one
  end

  teardown do
    @bulletin = bulletins :one
  end

  test '#index' do
    get admin_bulletins_path
    assert_response :success
  end

  # test '#approve' do
  #   patch publish_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.published?
  # end
  #
  # test '#reject' do
  #   patch reject_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.rejected?
  # end
  #
  # test '#archive' do
  #   patch archive_admin_bulletin_path @bulletin
  #
  #   assert @bulletin.archived?
  # end
end
