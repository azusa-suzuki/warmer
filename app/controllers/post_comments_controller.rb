class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    if @post_comment.save
      flash.now[:success] = 'コメントしました。'
      @post.create_notification_comment!(current_user, @post_comment.id)
      render 'create'
      # redirect_to post_path(@post)
    else
      flash.now[:danger] = 'コメントを入力してください。'
      render 'createfail'
      # redirect_to post_path(@post)
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:post_id])
    @post = @post_comment.post
    @post_comment.destroy
    flash.now[:success] = 'コメントを削除しました。'
    # redirect_to post_path(@post_comment.post.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
