class AddOwnerToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :owner_id, :integer, null:false
    add_index :cats, :owner_id, unique: true
  end
end
