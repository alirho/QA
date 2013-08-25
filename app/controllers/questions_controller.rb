class QuestionsController < ApplicationController
  
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.search(params[:search]).paginate(page: params[:page])
    @users = User.paginate(page: params[:page])
    @tags = Tag.all
    @total_questions = Question.all
    @total_answers = Answer.all
    @total_comments = Comment.all
    @total_tags = Tag.all
    @total_users = User.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = @question.answers
    @answer = @question.answers.build
    @question = Question.find(params[:id])
    Visit.track(@question, request.remote_ip)
    @comment = Comment.new
    @comment.question_id = @question.id
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:success] = t('controllers.questions.create.flash.success')
      redirect_to @question
    else
      render 'new'
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @question.update(question_params)
      flash[:success] = t('controllers.questions.update.flash.success')
      redirect_to @question
    else
      render  'edit'
    end  
  end
  
  

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    flash[:success] = t('controllers.questions.destroy.flash.success')
    redirect_to questions_url
  end
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @question = Question.find(params[:id])
    @question.add_or_update_evaluation(:votes, value, current_user)
    flash[:success] = t('controllers.questions.vote.flash.success')
    redirect_to :back
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end
        

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body, :user_id, :tag_list, :question_id)
    end
end
