class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment posted.'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
    redirect_to post_path(@post), alert: "Comment not found" unless @comment
  end

  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
