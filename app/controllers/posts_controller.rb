class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @post = Post.new
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to user_path(current_user.id), flash: { success: '投稿が完了しました。' }
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post), flash: { success: '変更が完了しました。' }
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id), flash: { success: '投稿を削除しました。' }
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :sex, :age, :type, :image)
  end
end
