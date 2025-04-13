class Bill < ApplicationRecord
  belongs_to :user

  enum :tipo_egreso,
        [ :egreso_default,
          :egreso_remuneracion,
          :egreso_util_aseo,
          :egreso_gasto_basico,
          :egreso_mantencion ]
end
