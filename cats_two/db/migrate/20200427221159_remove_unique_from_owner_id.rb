class RemoveUniqueFromOwnerId < ActiveRecord::Migration[5.2]
  def change
    remove_index :cats, :owner_id
    add_index :cats, :owner_id
  end
end
