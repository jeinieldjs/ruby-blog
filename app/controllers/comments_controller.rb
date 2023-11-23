class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment posted.'
    else
      # flash[:error] = 'Comment creation failed: ' + @comment.errors.full_messages.join('. ')
      render 'new', status: :unprocessable_entity
      # redirect_to post_path(@post)
    end
  end

  def edit
    @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment updated.'
    else
      # flash[:error] = 'Comment update failed: ' + @comment.errors.full_messages.join('. ')
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
