class CreateWorks < ActiveRecord::Migration[8.0]
  def change
    create_table :works do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
