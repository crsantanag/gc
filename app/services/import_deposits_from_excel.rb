require "roo"


class ImportDepositsFromExcel
  attr_reader :successful, :failed, :errors

  def initialize(file)
    @file = file
    @successful = []
    @failed = []
    @errors = []
  end

  def call
    spreadsheet = Roo::Spreadsheet.open(@file.path)
    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[ header, spreadsheet.row(i) ].transpose]

      deposit = Deposit.new(
        date: row["date"],
        tipo_ingreso: row["tipo_ingreso"],
        comment: row["comment"],
        amount: row["amount"],
        mes: row["mes"],
        ano: row["ano"],
        user_id: row["user_id"],
        apartment_id: row["apartment_id"]
      )

      if deposit.valid?
         deposit.save
         @successful << deposit
      else
         @failed << row
         @errors << { row: i, messages: deposit.errors.full_messages }
      end
    end

    self
  end
end
