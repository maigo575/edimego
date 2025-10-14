class PasswordChangesController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    email = params[:email] || @user.email
    
    begin
      # パスワードリセットメールを送信
      @user.send_reset_password_instructions
      redirect_to edit_password_change_path, notice: 'パスワード変更用のリンクをメールで送信しました。メール内のリンクから新しいパスワードを設定してください。'
    rescue => e
      Rails.logger.error "Password reset email error: #{e.message}"
      redirect_to edit_password_change_path, alert: 'メール送信に失敗しました。しばらく時間をおいて再度お試しください。'
    end
  end
end
