class PasswordChangesController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    # パスワードリセットメールを送信
    @user.send_reset_password_instructions
    redirect_to edit_password_change_path, notice: 'パスワード変更用のリンクをメールで送信しました。メール内のリンクから新しいパスワードを設定してください。'
  end
  
  private
  
  def password_change_params
    params.require(:user).permit(:email)
  end
end
