class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionHelper
  include ErrorHelper
  add_breadcrumb 'Home', :root_path
end
