# frozen_string_literal: true

class Web::Profile::HomeController < Web::Profile::ApplicationController
  def index
    @bulletins = current_user.bulletins.page params[:page]
  end
end
