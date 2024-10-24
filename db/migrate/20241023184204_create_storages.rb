class CreateStorages < ActiveRecord::Migration[8.0]
  def change
    create_table :storages do |t|
      t.string :macaddress
      t.integer :serialnumber
      t.string :lastcontact

      #t.timestamps
    end
  end
end
