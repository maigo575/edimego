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
      redirect_to edit_password_change_path, notice: "\u30D1\u30B9\u30EF\u30FC\u30C9\u5909\u66F4\u7528\u306E\u30EA\u30F3\u30AF\u3092\u30E1\u30FC\u30EB\u3067\u9001\u4FE1\u3057\u307E\u3057\u305F\u3002\u30E1\u30FC\u30EB\u5185\u306E\u30EA\u30F3\u30AF\u304B\u3089\u65B0\u3057\u3044\u30D1\u30B9\u30EF\u30FC\u30C9\u3092\u8A2D\u5B9A\u3057\u3066\u304F\u3060\u3055\u3044\u3002"
    rescue => e
      Rails.logger.error "Password reset email error: #{e.message}"
      redirect_to edit_password_change_path, alert: "\u30E1\u30FC\u30EB\u9001\u4FE1\u306B\u5931\u6557\u3057\u307E\u3057\u305F\u3002\u3057\u3070\u3089\u304F\u6642\u9593\u3092\u304A\u3044\u3066\u518D\u5EA6\u304A\u8A66\u3057\u304F\u3060\u3055\u3044\u3002"
    end
  end
end
