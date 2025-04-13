class PagesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
  end

  def balance
    @balance_inicial = session[:balance_inicial]

    year = session[:selected_year]
    fecha_inicio = Date.new(year, 1, 1)
    fecha_fin = Date.new(year, 12, 31)

    ingresos = current_user.deposits.where(date: fecha_inicio..fecha_fin).order(:date)
    egresos  = current_user.bills.where(date: fecha_inicio..fecha_fin).order(:date)

    # Unir todos los registros y agrupar por mes
    all_months = (ingresos + egresos).map { |r| r.date.beginning_of_month }.uniq.sort

    @balance_data = all_months.map do |month|
      mes_ingresos = ingresos.select { |i| i.date.beginning_of_month == month }
      mes_egresos  = egresos.select  { |e| e.date.beginning_of_month == month }

      {
        mes: month,
        ingresos: mes_ingresos.sum(&:amount),
        egresos: mes_egresos.sum(&:amount),
        registros: (mes_ingresos + mes_egresos).sort_by(&:date)
      }
    end

    @total_ingresos = ingresos.sum(&:amount)
    @total_egresos  = egresos.sum(&:amount)
    @balance_total  = @total_ingresos - @total_egresos
  end


  def set_year
    session[:selected_year] = (params[:year] || Date.today.year).to_i
    year = session[:selected_year]
    fecha_corte = Date.new(year - 1, 12, 31)

    ingresos = current_user.deposits.where("date <= ?", fecha_corte).sum(:amount)
    egresos = current_user.bills.where("date <= ?", fecha_corte).sum(:amount)

    session[:balance_inicial] = current_user.saldo_inicial + ingresos - egresos

    if params[:year].present?
          flash[:notice] = "AÑO SELECCIONADO - #{year}"
    end
    redirect_to request.referer || root_path
  end

  def page_params
    params.require(:page).permit(:id)
  end
end
