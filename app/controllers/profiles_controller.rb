class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      # reconfirmable では email は即時更新されず、unconfirmed_email に保持される
      notice_message = if @user.pending_reconfirmation? || @user.saved_change_to_unconfirmed_email?
        'メールアドレス変更の確認メールを送信しました。'
      else
        'プロフィールを更新しました。'
      end
      redirect_to mypage_path, notice: notice_message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:penname, :email)
  end
end 