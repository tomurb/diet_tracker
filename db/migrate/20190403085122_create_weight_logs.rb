class CreateWeightLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :weight_logs do |t|
      t.references :biometric, foreign_key: true
      t.integer :weight

      t.timestamps
    end
  end
end
