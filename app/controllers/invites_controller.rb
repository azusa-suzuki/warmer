class InvitesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @invite = Invite.new
  end

  def index
    @q = Invite.ransack(params[:q])
    @invites = @q.result.page(params[:page]).reverse_order
  end

  def show
    @invite = Invite.find(params[:id])
    @invite_comment = InviteComment.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.user_id = current_user.id
    @invite.save
    tags = Vision.get_image_data(@invite.image)
    tags.each do |tag|
      @invite.tags.create(name: tag)
    end
    redirect_to user_path(current_user.id), flash: { success: '投稿が完了しました。' }
  end

  def edit
    @invite = Invite.find(params[:id])
  end

  def update
    invite = Invite.find(params[:id])
    invite.update(invite_params)
    redirect_to invite_path(invite), flash: { success: '変更が完了しました。' }
  end

  def destroy
    invite = Invite.find(params[:id])
    invite.destroy
    redirect_to user_path(current_user.id), flash: { success: '投稿を削除しました。' }
  end

  private

  def invite_params
    params.require(:invite).permit(:title, :content, :sex, :age, :type, :image)
  end
end
