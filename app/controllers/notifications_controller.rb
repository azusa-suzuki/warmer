class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    # checked:false=未確認をtrue=確認済に更新する
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    flash[:success] = '通知を削除しました。'
    redirect_to notifications_path
  end
end
