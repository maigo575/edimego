class CustomDeviseMailer < Devise::Mailer
  default from: ENV.fetch("MAILER_SENDER", "no-reply@example.com")
  default template_path: "devise/mailer"

  # メールアドレス変更確認メールをカスタマイズ
  def confirmation_instructions(record, token, opts = {})
    @token = token
    @user = record
    @confirmation_url = user_confirmation_url(confirmation_token: token)

    mail(to: @user.unconfirmed_email || @user.email,
         subject: "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9\u5909\u66F4\u306E\u78BA\u8A8D\u3092\u304A\u9858\u3044\u3057\u307E\u3059",
         template_name: "confirmation_instructions")
  end

  # パスワードリセットメールをカスタマイズ
  def reset_password_instructions(record, token, opts = {})
    @token = token
    @user = record

    mail(to: @user.email,
         subject: "\u30D1\u30B9\u30EF\u30FC\u30C9\u5909\u66F4\u306E\u3054\u6848\u5185",
         template_name: "reset_password_instructions")
  end

  # パスワード変更通知メールをカスタマイズ
  def password_change(record, opts = {})
    @user = record

    mail(to: @user.email,
         subject: "\u30D1\u30B9\u30EF\u30FC\u30C9\u304C\u5909\u66F4\u3055\u308C\u307E\u3057\u305F",
         template_name: "password_change")
  end
end
