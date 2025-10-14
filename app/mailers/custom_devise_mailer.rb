class CustomDeviseMailer < Devise::Mailer
  default from: ENV.fetch('MAILER_SENDER', 'no-reply@example.com')
  default template_path: 'devise/mailer'

  # メールアドレス変更確認メールをカスタマイズ
  def confirmation_instructions(record, token, opts = {})
    @token = token
    @user = record
    @confirmation_url = user_confirmation_url(confirmation_token: token)
    
    mail(to: @user.unconfirmed_email || @user.email, 
         subject: 'メールアドレス変更の確認をお願いします',
         template_name: 'confirmation_instructions')
  end

  # パスワードリセットメールをカスタマイズ
  def reset_password_instructions(record, token, opts = {})
    @token = token
    @user = record
    
    mail(to: @user.email, 
         subject: 'パスワード変更のご案内',
         template_name: 'reset_password_instructions')
  end

  # パスワード変更通知メールをカスタマイズ
  def password_change(record, opts = {})
    @user = record
    
    mail(to: @user.email, 
         subject: 'パスワードが変更されました',
         template_name: 'password_change')
  end
end
