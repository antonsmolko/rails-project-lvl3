# frozen_string_literal: true

class Web::Profile::ApplicationController < Web::ApplicationController
  before_action :require_signed_in_user!
end
