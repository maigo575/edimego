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
        "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9\u5909\u66F4\u306E\u78BA\u8A8D\u30E1\u30FC\u30EB\u3092\u9001\u4FE1\u3057\u307E\u3057\u305F\u3002"
      else
        "\u30D7\u30ED\u30D5\u30A3\u30FC\u30EB\u3092\u66F4\u65B0\u3057\u307E\u3057\u305F\u3002"
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
