class PasswordChangesController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if @user.update_with_password(password_change_params)
      # パスワード変更通知メールを送信（Deviseが自動的に送信）
      bypass_sign_in(@user) # パスワード変更後もログイン状態を維持
      redirect_to edit_password_change_path, notice: 'パスワードを変更しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def password_change_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
