class Bill < ApplicationRecord
  belongs_to :user

  enum tipo_egreso: { egreso_default: 0, egreso_remuneracion: 1, egreso_util_aseo: 2, egreso_gasto_basico: 3, egreso_mantencion: 4  }
end
