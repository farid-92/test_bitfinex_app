class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :url, default: ''
      t.integer :service_type

      t.timestamps
    end
  end
end
