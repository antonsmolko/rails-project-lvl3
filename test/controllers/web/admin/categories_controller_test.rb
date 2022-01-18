# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @category = categories :one
    sign_in(@user)
  end

  test '#index' do
    get admin_categories_path
    assert_response :success
  end

  test '#new' do
    get new_admin_category_path
    assert_response :success
  end

  test '#create' do
    attrs = FactoryBot.attributes_for :category

    post admin_categories_path, params: { category: attrs }

    assert_response :redirect

    category = Category.find_by(name: attrs[:name])
    assert category
  end

  test '#edit' do
    get edit_admin_category_path @category
    assert_response :success
  end

  test '#update' do
    attrs = FactoryBot.attributes_for :category

    patch admin_category_path @category, params: { category: attrs }
    assert_response :redirect

    @category.reload

    assert @category.name == attrs[:name]
  end

  test '#destroy' do
    delete admin_category_path @category

    assert_response :redirect

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(@category.id) }
  end
end
