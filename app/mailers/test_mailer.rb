class TestMailer < ApplicationMailer
  default from: ENV.fetch("MAILER_SENDER", "no-reply@xn--v8jc9fuf1610a.com")

  def test_email(to_email, subject, message)
    @message = message
    @to_email = to_email
    @subject = subject || "テストメール - #{Time.current.strftime('%Y年%m月%d日 %H:%M')}"

    mail(
      to: to_email,
      subject: @subject
    )
  end
end
