class CreateDeposits < ActiveRecord::Migration[7.2]
  def change
    create_table :deposits do |t|
      t.date :date
      t.integer :amount
      t.string :comment
      t.integer :tipo_ingreso
      t.integer :mes
      t.integer :ano
      t.references :user, null: false, foreign_key: true
      t.references :apartment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
