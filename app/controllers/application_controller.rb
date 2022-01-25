# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthManagement
  include Pundit

  helper_method :signed_in?, :sign_out
end
