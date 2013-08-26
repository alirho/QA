class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @total_questions = @user.questions
    @questions = @total_questions
    @total_answers = @user.answers
    @answers = @user.answers.includes(:question)
    @total_comments = @user.comments
    @comments = @user.comments.includes(:question)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = t('controllers.users.create.flash.success')
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
        
  end
  
  def update
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = t('controllers.users.update.flash.success')
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t('controllers.users.destroy.flash.success')
    redirect_to root_url
  end
  
  
  private
  
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation,
        :location, :website, :aboutme, :realname)
    end
    
    def signed_in_user
	unless signed_in?
	  store_locatin
	  redirect_to signin_url, notice: "Please sign in"
	end
    end
    
    def correct_user
	@user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
	redirect_to(root_path) unless current_user.admin?
    end
end
