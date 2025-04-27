require "roo"

class ImportBillsFromExcel
  def initialize(file)
    @file = file
  end

  def call
    spreadsheet = Roo::Spreadsheet.open(@file.path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[ header, spreadsheet.row(i) ].transpose]

      Bill.create!(
        date: row["date"],
        tipo_egreso: row["tipo_egreso"],
        comment: row["comment"],
        amount: row["amount"],
        user_id: row["user_id"],
      )
    end
  end
end
