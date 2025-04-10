class CreateBills < ActiveRecord::Migration[7.2]
  def change
    create_table :bills do |t|
      t.date :date
      t.integer :amount
      t.integer :tipo_ingreso
      t.string :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
