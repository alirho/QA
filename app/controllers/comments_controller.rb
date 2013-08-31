class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.question_id = params[:question_id]
    @comment.user = current_user
    @comment.save
    flash[:success] = t('controllers.comments.create.flash.success')
    redirect_to question_path(@comment.question)
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(comment_params)
    redirect_to @comment.question
    flash[:success] = t('controllers.comments.update.flash.success')
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = t('controllers.comments.destroy.flash.success')
    redirect_to question_path(@comment.question)
  end
  
  private
  
  def comment_params
      params.require(:comment).permit(:body, :user_id, :question_id)
  end
end
