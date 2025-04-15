module DepositsHelper
  def nombre_tipo_ingreso(tipo)
    I18n.t("activerecord.attributes.deposit.tipo_ingreso.#{tipo}", default: tipo.to_s.humanize)
  end
end

def tipo_ingreso_humano(tipo)
  {
    "ingreso_comun"           => "Gastos comunes",
    "ingreso_extraordinario"  => "Ingreso extraordinario",
    "ingreso_otro"            => "Otros ingresos"
  }[tipo] || tipo.to_s.humanize
end
