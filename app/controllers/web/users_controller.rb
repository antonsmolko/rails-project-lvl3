# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  def profile
    @user = User.find(params[:id])
  end
end
