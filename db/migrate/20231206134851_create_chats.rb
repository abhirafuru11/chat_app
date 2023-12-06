class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.boolean :archived, default: false
      t.text :body
      t.integer :sender_type
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
