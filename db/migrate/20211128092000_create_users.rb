# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.boolean :is_admin

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
