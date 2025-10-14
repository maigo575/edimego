class EmailChangesController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    begin
      if @user.update_with_password(email_change_params)
        # メールアドレス変更の確認メールを送信
        if @user.pending_reconfirmation?
          @user.send_confirmation_instructions
          redirect_to edit_email_change_path, notice: '確認メールを送信しました。新しいメールアドレスを確認してください。'
        else
          redirect_to edit_email_change_path, notice: 'メールアドレスを変更しました。'
        end
      else
        render :edit, status: :unprocessable_entity
      end
    rescue => e
      Rails.logger.error "Email change error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to edit_email_change_path, alert: "メールアドレス変更に失敗しました。しばらく時間をおいて再度お試しください。"
    end
  end
  
  private
  
  def email_change_params
    params.require(:user).permit(:email, :current_password)
  end
end
