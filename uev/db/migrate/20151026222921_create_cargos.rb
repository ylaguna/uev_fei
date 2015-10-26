class CreateCargos < ActiveRecord::Migration
  def change
     create_table :cargos do |t|
      t.string :name
      t.string :type
      t.integer :ueg

      t.timestamps null: false
    end
  end
end
