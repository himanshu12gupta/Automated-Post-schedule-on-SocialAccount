class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    new_handler_path
  end
  def after_sign_up_path_for(resource)
    root_path
  end

  # Redirect to the home page after sign out
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
