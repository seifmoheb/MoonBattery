class CreateConfigurations < ActiveRecord::Migration[8.0]
  def change
    create_table :configurations do |t|
      t.string :macAddress
      t.string :configuration
      t.string :value
      # t.timestamps
    end
  end
end
