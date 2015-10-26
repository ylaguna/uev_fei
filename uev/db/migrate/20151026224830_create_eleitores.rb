class CreateEleitores < ActiveRecord::Migration
  def change
    create_table :eleitores do |t|
      t.string :name
      t.string :photo_url
      t.string :doc
      t.integer :status
      t.integer :ueg
      
      t.timestamps null: false
    end
  end
end
