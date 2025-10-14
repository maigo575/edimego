class TestMailsController < ApplicationController
  before_action :authenticate_user!

  def new
    # メール設定情報を取得
    @mailer_config = get_mailer_config
  end

  def create
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]

    begin
      # テストメール送信
      TestMailer.test_email(@email, @subject, @message).deliver_now
      redirect_to new_test_mail_path, notice: "テストメールを送信しました: #{@email}"
    rescue => e
      redirect_to new_test_mail_path, alert: "メール送信エラー: #{e.message}"
    end
  end

  private

  def test_mail_params
    params.permit(:email, :subject, :message)
  end

  def get_mailer_config
    smtp_settings = ActionMailer::Base.smtp_settings

    if ENV["GMAIL_USERNAME"].present?
      {
        provider: "Gmail SMTP",
        server: "smtp.gmail.com",
        port: 587,
        auth_status: ENV["GMAIL_APP_PASSWORD"].present? ? "\u2705 \u8A2D\u5B9A\u6E08\u307F" : "\u274C \u672A\u8A2D\u5B9A",
        sender: ENV.fetch("MAILER_SENDER", "no-reply@xn--v8jc9fuf1610a.com")
      }
    elsif ENV["BREVO_SMTP_USERNAME"].present?
      {
        provider: "Brevo SMTP",
        server: "smtp-relay.brevo.com",
        port: 587,
        auth_status: "\u2705 \u8A2D\u5B9A\u6E08\u307F",
        sender: ENV.fetch("MAILER_SENDER", "no-reply@xn--v8jc9fuf1610a.com")
      }
    else
      {
        provider: "Letter Opener (\u958B\u767A\u74B0\u5883)",
        server: "\u30ED\u30FC\u30AB\u30EB\u30D5\u30A1\u30A4\u30EB",
        port: "N/A",
        auth_status: "\u2705 \u8A2D\u5B9A\u6E08\u307F",
        sender: ENV.fetch("MAILER_SENDER", "no-reply@xn--v8jc9fuf1610a.com")
      }
    end
  end
end
