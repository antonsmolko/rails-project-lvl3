# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def new?
    @user
  end

  def create?
    @user
  end

  def edit?
    @user
  end

  def update?
    author?
  end

  def to_moderate?
    author?
  end

  def archive?
    author?
  end
end