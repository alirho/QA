class AnswersController < ApplicationController

  def new
    @answer = Answer.new
  end
  
  def create
    @question = Question.find(params[:answer][:question_id])
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
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
