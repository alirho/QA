class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.question_id = params[:question_id]
    @comment.user = current.user
    @comment.save
    flash[:notice] = "Comment has been created!"
    redirect_to question_path(@comment.question)
  end
  
  private
  
  def comment_params
      params.require(:comment).permit(:body, :user_id, :question_id)
  end
end
