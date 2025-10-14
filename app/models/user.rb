class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :works, dependent: :destroy
  
  # メールアドレス変更時の確認メール送信
  def send_confirmation_instructions
    if pending_reconfirmation?
      deliver_confirmation_instructions
    end
  end
  
  # パスワード変更通知メール送信
  def send_password_change_notification
    # Deviseの標準的なパスワード変更通知メールを送信
    # このメソッドはDeviseが自動的に呼び出すため、カスタマイズが必要な場合のみ実装
  end
end
