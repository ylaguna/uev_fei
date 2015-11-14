class AddCargoToVote < ActiveRecord::Migration
  def change
    add_column :votos, :cargo_id, :integer
  end
end
