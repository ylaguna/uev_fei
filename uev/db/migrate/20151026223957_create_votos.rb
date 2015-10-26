class CreateVotos < ActiveRecord::Migration
  def change
    create_table :votos do |t|
      t.integer :value
    end
  end
end
