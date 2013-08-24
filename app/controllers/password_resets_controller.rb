class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = t('controllers.password_resets.create.flash.success')
    redirect_to root_url
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t('controllers.password_resets.update.flash.fail')
    elsif @user.update_attributes(user_params)
      flash[:success] = t('controllers.password_resets.update.flash.success')
      redirect_to root_url
    else
      render :edit
    end
  end
  
  private
  
    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end
  
end
