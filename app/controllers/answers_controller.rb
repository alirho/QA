class AnswersController < ApplicationController
  before_action :signed_in_user
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to @answer.question
  end
  
  
  def edit
    @answer = Answer.find(params[:id])
  end
  
  def update
    @answer = Answer.find(params[:id])
    @answer.update_attributes(answer_params)
    redirect_to @answer.question
  end
  
  def destroy
    @answer = Answer.find(params[:id])
    @question.answers.destroy
    redirect_to @answer.question, :notice => "Successfully destroyed answer."
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @answer = Answer.find(params[:id])
    @answer.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
