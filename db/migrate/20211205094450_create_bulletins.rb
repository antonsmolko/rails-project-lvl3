class CreateBulletins < ActiveRecord::Migration[6.1]
  def change
    create_table :bulletins, force: :cascade do |t|
      t.string :name
      t.text :description
      t.string :aasm_state

      t.timestamps

      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
