class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
    
      if @comment.save
        redirect_to post_path(@post), notice: 'Comment was successfully created.'
      else
        
        flash[:error] = 'Comment creation failed: ' + @comment.errors.full_messages.join('. ')
        redirect_to post_path(@post)
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  