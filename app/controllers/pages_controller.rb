class PagesController < ApplicationController
  skip_before_action :require_year, only: [ :index, :set_year ]
  def index
  end
  def exito
    @usuario = User.find(params[:id])
  end

  def balance
    year = selected_year
    @balance_inicial = session[:balance_inicial] || 0
    @año = year


    ingresos = current_user.deposits.where(date: Date.new(year)..Date.new(year, 12, 31)).order(:date)
    egresos = current_user.t.bills.where(date: Date.new(year)..Date.new(year, 12, 31)).order(:date)

    all_months = (ingresos + egresos).map { |r| r.date.beginning_of_month }.uniq.sort

    @balance = {}
    acumulado = @balance_inicial

    all_months.each do |month|
      ingresos_mes = ingresos.select { |i| i.date.beginning_of_month == month }
      egresos_mes = egresos.select { |e| e.date.beginning_of_month == month }

      total_ingresos = ingresos_mes.sum(&:amount)
      total_egresos = egresos_mes.sum(&:amount)
      balance_mes = total_ingresos - total_egresos
        acumulado += balance_mes

      @balance[month] = {
        registros: (ingresos_mes + egresos_mes).sort_by(&:date),
        total_ingresos: total_ingresos,
        total_egresos: total_egresos,
        balance: balance_mes,
        acumulado: acumulado
      }
    end
  end

  def set_year
    session[:selected_year] = params[:year].to_i
    year = session[:selected_year]
    fecha_corte = Date.new(year - 1, 12, 31)

    ingresos = current_user.deposits.where("date <= ?", fecha_corte).sum(:amount)
    egresos = current_user.bills.where("date <= ?", fecha_corte).sum(:amount)

    session[:balance_inicial] = ingresos - egresos
    flash[:notice] = "AÑO SELECCIONADO - #{year}"
    redirect_to request.referer || root_path
  end

  def page_params
    params.require(:page).permit(:id)
  end
end
