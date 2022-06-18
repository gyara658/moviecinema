class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #サインインした後にどのページに移動するか
  def after_sign_up_path_for(*)
    # user_path(resource.id)
    root_path
  end

  protected

  # deviseのpermitted_parameterを追加する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    # 登録時も必要であればsign_upを追加
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar] )
  end
end
