class CreateBulletins < ActiveRecord::Migration[6.1]
  def change
    create_table :bulletins, force: :cascade do |t|
      t.string :title
      t.text :description
      t.string :state

      t.timestamps

      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
