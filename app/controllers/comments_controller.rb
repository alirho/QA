class CommentsController < ApplicationController

 def new
   
 end
 
 def create
   @comment = Comment.new(params[:comment])
   @comment.questions_id = params[:questions_id]
   @comment.save
   
   redirect_to question_path
 end
end
