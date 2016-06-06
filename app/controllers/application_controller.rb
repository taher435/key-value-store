class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token

  def default_action
    render :text => "You have reached a test implementation of key store value API. Read about it here."
  end
end
