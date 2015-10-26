class CreateCandidatos < ActiveRecord::Migration
  def change
    create_table :candidatos do |t|
      t.string :name
      t.string :nickname
      t.string :number
      t.string :photo_url
      t.integer :cargo_id
      t.integer :ueg

      t.timestamps null: false
    end
  end
end
