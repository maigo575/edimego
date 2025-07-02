class AddPennameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :penname, :string
  end
end
