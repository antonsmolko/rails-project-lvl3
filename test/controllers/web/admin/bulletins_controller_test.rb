# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    sign_in(@user)
    @bulletin = bulletins :draft
  end

  test '#index' do
    get admin_bulletins_path
    assert_response :success
  end

  test '#approve' do
    bulletin = bulletins :under_moderation

    patch publish_admin_bulletin_path bulletin

    bulletin.reload

    assert bulletin.published?
  end

  test '#reject' do
    bulletin = bulletins :under_moderation

    patch reject_admin_bulletin_path bulletin

    bulletin.reload

    assert bulletin.rejected?
  end

  test '#archive' do
    bulletin = bulletins :under_moderation

    patch archive_admin_bulletin_path bulletin

    bulletin.reload

    assert bulletin.archived?
  end
end
