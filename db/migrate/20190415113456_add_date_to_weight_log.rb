class AddDateToWeightLog < ActiveRecord::Migration[5.2]
  def change
    add_column :weight_logs, :date, :date
  end
end
