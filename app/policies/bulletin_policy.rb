# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

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

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  def archive?
    author? || admin?
  end
end
