// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "rails-ujs";
Rails.start();
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('register-form');
  const penname = document.getElementById('penname');
  const email = document.getElementById('email');
  const password = document.getElementById('password');
  const passwordConfirmation = document.getElementById('password_confirmation');
  const successMessage = document.getElementById('success-message');

  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      let valid = true;

      // ペンネーム
      if (!penname.value.trim()) {
        document.getElementById('penname-error').textContent = 'ペンネームは必須です';
        valid = false;
      } else {
        document.getElementById('penname-error').textContent = '';
      }

      // メール
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!email.value.trim()) {
        document.getElementById('email-error').textContent = 'メールアドレスは必須です';
        valid = false;
      } else if (!emailPattern.test(email.value)) {
        document.getElementById('email-error').textContent = 'メールアドレスの形式が正しくありません';
        valid = false;
      } else {
        document.getElementById('email-error').textContent = '';
      }

      // パスワード
      if (!password.value) {
        document.getElementById('password-error').textContent = 'パスワードは必須です';
        valid = false;
      } else if (password.value.length < 8) {
        document.getElementById('password-error').textContent = '8文字以上で入力してください';
        valid = false;
      } else {
        document.getElementById('password-error').textContent = '';
      }

      // パスワード確認
      if (!passwordConfirmation.value) {
        document.getElementById('password_confirmation-error').textContent = 'パスワード確認を入力してください';
        valid = false;
      } else if (password.value !== passwordConfirmation.value) {
        document.getElementById('password_confirmation-error').textContent = 'パスワードが一致しません';
        valid = false;
      } else {
        document.getElementById('password_confirmation-error').textContent = '';
      }

      if (valid) {
        successMessage.textContent = '登録が完了しました！（仮）';
        form.reset();
      } else {
        successMessage.textContent = '';
      }
    });
  }
});
