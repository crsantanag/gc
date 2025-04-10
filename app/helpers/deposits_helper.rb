module DepositsHelper
  def nombre_tipo_ingreso(tipo)
    I18n.t("activerecord.attributes.deposit.tipo_ingreso.#{tipo}", default: tipo.to_s.humanize)
  end
end
