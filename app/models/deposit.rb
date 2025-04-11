class Deposit < ApplicationRecord
  belongs_to :user
  belongs_to :apartment

  enum tipo_ingreso: {
     ingreso_default: 0,
     ingreso_comun: 1,
     ingreso_extraordinario: 2,
     ingreso_otro: 3 }

  validates :mes, :ano, presence: true, if: -> { tipo_ingreso == "ingreso_comun" }

  MONTHS = [
    [ "Enero", 1 ],
    [ "Febrero", 2 ],
    [ "Marzo", 3 ],
    [ "Abril", 4 ],
    [ "Mayo",  5 ],
    [ "Junio", 6 ],
    [ "Julio", 7 ],
    [ "Agosto",  8 ],
    [ "Septiembre", 9 ],
    [ "Octubre", 10 ],
    [ "Noviembre", 11 ],
    [ "Diciembre", 12 ] ]

  YEARS  = [ [ "2025", 2025 ], [ "2024", 2024 ], [ "2023", 2023 ], [ "2022", 2022 ], [ "2021",  2021 ], [ "2020", 2020 ] ]

  def import
    file = params[:file]

    if file.nil?
      flash[:alert] = "Debes seleccionar un archivo Excel."
      redirect_to deposits_path and return
    end

    begin
      spreadsheet = Roo::Spreadsheet.open(file.path) # Abre el archivo
      header = spreadsheet.row(1) # Obtiene la primera fila como encabezado

      # Itera desde la segunda fila en adelante
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[ header, spreadsheet.row(i) ].transpose]
        deposit = Deposit.new(
          date: row["Fecha"],
          amount: row["Cantidad"].to_i,
          comment: row["Comentario"],
          tipo_ingreso: row["Tipo de Ingreso"],
          mes: row["Mes"].to_i,
          ano: row["Año"].to_i,
          user_id: current_user.id,
          apartment_id: row["Departamento ID"].to_i
        )
        deposit.save!
      end

      flash[:notice] = "Datos importados correctamente."
    rescue => e
      flash[:alert] = "Error al importar: #{e.message}"
    end

    redirect_to deposits_path
  end
end
