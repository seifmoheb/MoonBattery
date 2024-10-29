class ChangeMacaddressToPrimaryKeyInStorages < ActiveRecord::Migration[6.0]
  def change
    remove_column :storages, :id 
    change_column :storages, :macaddress, :string, null: false, unique: true 
    execute "ALTER TABLE storages ADD PRIMARY KEY (macaddress);"
  end
end