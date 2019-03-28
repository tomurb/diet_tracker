class CreateBiometrics < ActiveRecord::Migration[5.2]
  def change
    create_table :biometrics do |t|
      t.references :user, foreign_key: true
      t.string :gender
      t.integer :age
      t.integer :weight
      t.integer :height

      t.timestamps
    end
  end
end
