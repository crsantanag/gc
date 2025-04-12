class BillsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_year
  before_action :set_bill, only: %i[ show edit update destroy ]

  # GET /bills or /bills.json
  def index
    # Año ya lo tengo definido
    year = selected_year

    from_month = (params[:from_month] || 1).to_i
    to_month = (params[:to_month] || 12).to_i

    @from_date = Date.new(year, from_month, 1)
    @to_date = Date.new(year, to_month, -1) # último día del mes

    @bills = current_user.bills.where(date: @from_date..@to_date).order(date: :asc)

    params[:grouping] ||= "by_month"  # <= esta línea agrega el valor por defecto

    case params[:grouping]
    when "by_type"
      @bills_by_month = @bills.group_by(&:tipo_egreso)
    else # "by_month" o valor desconocido
      @bills_by_month = @bills.group_by { |b| b.date.beginning_of_month }
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Egresos",
               template: "bills/index",
               encoding: "UTF-8",
               layout: "pdf",
               orientation: "Portrait",
               page_size: "Letter"
      end
    end
  end

  # GET /bills/1 or /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = current_user.bills.new
    @bill.date ||= Date.today # Asigna la fecha de hoy
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills or /bills.json
  def create
    @bill = current_user.bills.new(bill_params)
    @bill.user_id = current_user.id

    respond_to do |format|
      if @bill.save
        flash[:notice] = "EGRESO REGISTRADO"
        format.html { redirect_to bills_path(from_month: params[:from_month], to_month: params[:to_month]) }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      flash[:notice] = "EGRESO ACTUALIZADO"
      if @bill.update(bill_params)
        format.html { redirect_to bills_path(from_month: params[:from_month], to_month: params[:to_month]) }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    @bill.destroy!

    respond_to do |format|
      format.html { redirect_to bills_path, status: :see_other, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = current_user.bills.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_params
      params.require(:bill).permit(:date, :tipo_egreso, :comment, :amount, :user_id)
    end
end
