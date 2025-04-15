class Bill < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  enum :tipo_egreso,
        [ :egreso_default,
          :egreso_remuneracion,
          :egreso_util_aseo,
          :egreso_gasto_basico,
          :egreso_mantencion,
          :egreso_otro ]
end
