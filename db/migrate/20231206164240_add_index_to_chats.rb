class AddIndexToChats < ActiveRecord::Migration[7.1]
  def change
    add_index :chats, :archived
  end
end
