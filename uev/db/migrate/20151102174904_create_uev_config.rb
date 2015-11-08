class CreateUevConfig < ActiveRecord::Migration
  def change
    create_table :uev_configs do |t|
      t.integer :status
      t.string :desc
    end
  end
end
