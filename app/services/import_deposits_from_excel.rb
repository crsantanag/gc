require "roo"

class ImportDepositsFromExcel
  def initialize(file)
    @file = file
  end

  def call
    spreadsheet = Roo::Spreadsheet.open(@file.path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[ header, spreadsheet.row(i) ].transpose]

      Deposit.create!(
        date: row["date"],
        tipo_ingreso: row["tipo_ingreso"],
        comment: row["comment"],
        amount: row["amount"],
        mes: row["mes"],
        ano: row["ano"],
       user_id: row["user_id"],
       apartment_id: row["apartment_id"]
        # Agrega más campos si tu modelo los requiere
      )
    end
  end
end
