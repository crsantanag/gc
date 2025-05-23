class DepositsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_deposit, only: %i[ show edit update destroy ]

  def import
    if params[:file].blank?
      flash[:alert] = "DEBE SELECCIONAR UN ARCHIVO"
      redirect_to deposits_path
      return
    end

    importer = ImportDepositsFromExcel.new(params[:file])
    importer.call

    if importer.errors.any?
      flash[:alert] = "#{importer.failed.count} REGISTROS NO IMPORTADOS"
      flash[:import_errors] = importer.errors
    else
      flash[:notice] = "IMPORTACIÓN COMPLETADA EXITOSAMENTE"
    end
    redirect_to deposits_path
  end

  # GET /deposits or /deposits.json
  def index
    # Año ya lo tengo definido
    year = selected_year

    from_month = params[:from_month].to_i
    to_month = params[:to_month].to_i

    from_month = 1 unless (1..12).include?(from_month)
    to_month = 12 unless (1..12).include?(to_month)

    @from_date = Date.new(year, from_month, 1)
    @to_date = Date.new(year, to_month, -1)

    @deposits = current_user.deposits.where(date: @from_date..@to_date).order(:date)

    base_scope = current_user.deposits.includes(:apartment).where(ano: year, mes: from_month..to_month)
    @deposits_by_ano_mes = base_scope.joins(:apartment).order("apartments.number ASC, deposits.ano ASC, deposits.mes ASC, deposits.date ASC, deposits.tipo_ingreso ASC")
    @deposits_by_month = base_scope.joins(:apartment).order("deposits.mes ASC, apartments.number ASC, deposits.date ASC")

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Ingresos",
               template: "deposits/index",
               encoding: "UTF-8",
               layout: "pdf",
               orientation: "Portrait",
               page_size: "Letter"
      end
    end
  end

  # GET /deposits/1 or /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    @apartments = current_user.apartments
    @deposit = current_user.deposits.new
    @deposit.date ||= Date.today # Asigna la fecha de hoy
  end

  # GET /deposits/1/edit
  def edit
    @apartments = current_user.apartments
    @deposit = current_user.deposits.find(params[:id])
  end

  # POST /deposits or /deposits.json
  def create
    @apartments = current_user.apartments
    @deposit = current_user.deposits.new(deposit_params)
    @deposit.user_id = current_user.id

    if @deposit.tipo_ingreso != "ingreso_comun"
      @deposit.mes = @deposit.date.month
      @deposit.ano = @deposit.date.year
    end

    respond_to do |format|
      if @deposit.save
        flash[:notice] = "INGRESO REGISTRADO"
        format.html { redirect_to filtered_redirect  }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1 or /deposits/1.json
  def update
    @deposit.assign_attributes(deposit_params)

    if @deposit.tipo_ingreso != "ingreso_comun"
       @deposit.mes = @deposit.date.month
       @deposit.ano = @deposit.date.year
    end

    respond_to do |format|
      if @deposit.save
        flash[:notice] = "INGRESO ACTUALIZADO"
        format.html { redirect_to filtered_redirect }
        format.json { render :show, status: :ok, location: @deposit }
      else
        @apartments = current_user.apartments
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1 or /deposits/1.json
  def destroy
    @deposit.destroy!
    flash[:notice] = "INGRESO ELIMINADO"
    respond_to do |format|
      format.html { redirect_to filtered_redirect, status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = current_user.deposits.find(params[:id])
    end

    def filtered_redirect
      allowed_params = %i[from_month to_month grouping]
      filtered = params.slice(*allowed_params).to_unsafe_h.compact_blank
      deposits_path(filtered)
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.require(:deposit).permit(:date, :amount, :comment, :tipo_ingreso, :mes, :ano, :user_id, :apartment_id)
    end
end
