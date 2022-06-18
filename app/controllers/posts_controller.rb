class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def create
    # cont = params[:content]

    p = post_params
    user = User.find(p[:id])
    if p[:body].empty?
      flash[:alert] = "空白のままコメントすることはできません"
      redirect_to request.referer
    elsif user.posts.create(
      body: p[:body], submitter: current_user.id, review: p[:review],
      image: p[:image], poster_path: p[:poster_path]
    )
      flash[:notice] = "コメントが投稿されました。"
      # redirect_to request.referer
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      # redirect_to request.referer
    end
    redirect_to request.referer
  end

  def edit
  end

  def update
    redirect_to root_path if @post.update(post_params)
  end

  def destroy
    @post.destroy!
    redirect_to root_path
  end

  protected

  def post_params
    params.require(:post).permit(:body, :id, :review, :image, :poster_path)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
