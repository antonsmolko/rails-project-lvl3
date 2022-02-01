# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @bulletin = bulletins :one
    @category = categories :two

    sign_in(@user)
  end

  test '#index' do
    get bulletins_path
    assert_response :success
  end

  test '#new' do
    get new_bulletin_path
    assert_response :success
  end

  test '#create' do
    attrs = {
      title: 'Test Bulletin Title',
      description: 'Test Bulletin Description',
      category_id: @category.id,
      image: fixture_file_upload('test/fixtures/files/image-2.jpeg')
    }

    post bulletins_path, params: { bulletin: attrs }

    assert_response :redirect

    bulletin = Bulletin.find_by(title: attrs[:title])

    assert bulletin
  end

  test '#edit' do
    get edit_bulletin_path @bulletin
    assert_response :success
  end

  # test '#update' do
  #   attrs = {
  #     title: 'Test Bulletin Title Updated',
  #     description: 'Test Bulletin Description Updated',
  #     category_id: @category.id,
  #     image: fixture_file_upload('test/fixtures/files/image-3.jpeg')
  #   }
  #
  #   put bulletin_path @bulletin, params: { bulletin: attrs }
  #   assert_response :redirect
  #
  #   @bulletin.reload
  #
  #   assert @bulletin.title == @update_attrs[:title]
  # end

  # test '#to_moderate' do
  #   bulletin = bulletins :draft
  #   assert bulletin.draft?
  #
  #   patch to_moderate_bulletin_path bulletin
  #   assert_response :redirect
  #
  #   bulletin.reload
  #
  #   assert bulletin.under_moderation?
  # end

  # test '#archived' do
  #   bulletin = bulletins :one
  #   patch archive_bulletin_path bulletin
  #
  #   assert @bulletin.archived?
  # end
end
