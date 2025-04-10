module ApplicationHelper
  # app/helpers/application_helper.rb
  def selected_year
    session[:selected_year]
  end

  def selected_year?
    session[:selected_year].present?
  end

  def formato_monto(monto)
    classes = monto.negative? ? "text-danger" : "text-dark"
    contenido = number_to_currency(monto, unit: "$", delimiter: ".", precision: 0)
    tag.span(contenido, class: classes)
  end
end
