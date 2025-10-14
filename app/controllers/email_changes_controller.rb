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
          redirect_to edit_email_change_path, notice: "\u78BA\u8A8D\u30E1\u30FC\u30EB\u3092\u9001\u4FE1\u3057\u307E\u3057\u305F\u3002\u65B0\u3057\u3044\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9\u3092\u78BA\u8A8D\u3057\u3066\u304F\u3060\u3055\u3044\u3002"
        else
          redirect_to edit_email_change_path, notice: "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9\u3092\u5909\u66F4\u3057\u307E\u3057\u305F\u3002"
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
