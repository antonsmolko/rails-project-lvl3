# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @bulletin = bulletins :draft
    @category = categories :two
    @uploaded_file = Rack::Test::UploadedFile.new('test/fixtures/files/image-2.jpeg')
    # @uploaded_file = fixture_file_upload('test/fixtures/files/image-2.jpeg')

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
      image: @uploaded_file
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

  test '#update' do
    attrs = {
      title: 'Test Bulletin Title Updated',
      description: 'Test Bulletin Description Updated',
      category_id: @category.id,
      # FIXME: causes ActiveSupport::MessageVerifier::InvalidSignature for some reason
      # image: @uploaded_file
    }

    put bulletin_path @bulletin, params: { bulletin: attrs }
    assert_response :redirect

    @bulletin.reload

    assert @bulletin.title == attrs[:title]
  end

  test '#to_moderate' do
    bulletin = bulletins :draft

    patch to_moderate_bulletin_path bulletin

    bulletin.reload

    assert bulletin.under_moderation?
  end

  test '#archived' do
    bulletin = bulletins :draft
    patch archive_bulletin_path bulletin

    bulletin.reload

    assert bulletin.archived?
  end
end
