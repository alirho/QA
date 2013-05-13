class CommentsController < ApplicationController

 def new
   @item = Question.find(params[:question_id]) if params[:question_id]
    @comment = @item.comments.new
    render :new, :layout => false
 end
 
 def create
   @comment = current_user.comments.new(params[:comment])
    if @comment.save
      render :json => render_to_string(:partial => 'comments/comment', :locals => { :comment => @comment }).to_json
    end
 end
end
