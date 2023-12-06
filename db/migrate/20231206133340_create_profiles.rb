class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.integer :category, default: 0, null: false
      t.integer :gender, default: 0, null: false

      t.timestamps
    end
  end
end
