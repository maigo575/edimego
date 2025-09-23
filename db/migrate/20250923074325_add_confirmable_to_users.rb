class AddConfirmableToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_index :users, :unconfirmed_email
    add_index :users, :confirmation_token, unique: true

    # 既存ユーザーを有効化状態に保つため、confirmed_at を埋める
    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE users
          SET confirmed_at = COALESCE(confirmed_at, updated_at)
          WHERE confirmed_at IS NULL;
        SQL
      end
    end
  end
end
