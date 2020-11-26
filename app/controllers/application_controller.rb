class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger
  before_action :flash_message

  protected

  # 会員新規登録の際にデータ保存する為に以下のカラムを記載
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name handle_name prefecture])
  end

  # 非同期通信時のフラッシュメッセージが遷移先に残るのを防ぐため
  def flash_message
    flash.discard
  end
end
