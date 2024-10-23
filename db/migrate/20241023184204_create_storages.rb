class CreateStorages < ActiveRecord::Migration[8.0]
  def change
    create_table :storages do |t|
      t.string :macAddress
      t.integer :serialNumber
      t.string :lastContact

      t.timestamps
    end
  end
end
