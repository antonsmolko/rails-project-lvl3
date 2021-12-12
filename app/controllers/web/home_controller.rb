# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @query = Bulletin.published.ransack(params[:q])
    @bulletins = @query.result(distinct: true).page params[:page]
  end
end
