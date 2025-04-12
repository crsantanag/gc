class DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_year
  before_action :set_deposit, only: %i[ show edit update destroy ]

  # GET /deposits or /deposits.json
  def index
    # Año ya lo tengo definido
    year = selected_year

    from_month = (params[:from_month] || 1).to_i
    to_month = (params[:to_month] || 12).to_i

    @from_date = Date.new(year, from_month, 1)
    @to_date = Date.new(year, to_month, -1) # úl

    @deposits = current_user.deposits.includes(:apartment).where(date: @from_date..@to_date).order(:date)
    @deposits_by_month = @deposits.group_by { |b| b.date.beginning_of_month }

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

    respond_to do |format|
      if @deposit.save
        flash[:notice] = "INGRESO REGISTRADO"
        format.html { redirect_to deposits_path(from_month: params[:from_month], to_month: params[:to_month]) }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1 or /deposits/1.json
  def update
    respond_to do |format|
      if @deposit.update(deposit_params)
        flash[:notice] = "INGRESO ACTUALIZADO"
        format.html { redirect_to deposits_path(from_month: params[:from_month], to_month: params[:to_month]) }
        format.json { render :show, status: :ok, location: @deposit }
      else
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
      format.html { redirect_to deposits_path(from_month: params[:from_month], to_month: params[:to_month]), status: :see_other, notice: "Deposit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = current_user.deposits.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.require(:deposit).permit(:date, :amount, :comment, :tipo_ingreso, :mes, :ano, :apartment_id)
    end
end
