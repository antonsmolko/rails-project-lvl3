class CreateBulletins < ActiveRecord::Migration[6.1]
  def change
    create_table :bulletins do |t|
      t.string :name
      t.text :description

      t.timestamps

      t.references :category, index: true, foreign_key: true
      t.references :creator, index: true, foreign_key: { to_table: :users }
    end
  end
end
