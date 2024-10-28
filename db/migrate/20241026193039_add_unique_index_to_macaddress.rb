class AddUniqueIndexToMacaddress < ActiveRecord::Migration[8.0]
  def change
    add_index :storages, :macaddress, unique: true
  end  
end
