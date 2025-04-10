module BillsHelper
  def tipo_egreso_humano(tipo)
    {
      "egreso_remuneracion" => "Remuneraciones",
      "egreso_util_aseo"    => "Útiles de aseo",
      "egreso_gasto_basico" => "Gastos básicos",
      "egreso_mantencion"   => "Mantenciones",
      "egreso_otro"         => "Otros"
    }[tipo] || tipo.to_s.humanize
  end
end
