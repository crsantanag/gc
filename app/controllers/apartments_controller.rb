class ApartmentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_apartment, only: %i[ show edit update destroy ]

  # GET /apartments or /apartments.json
  def index
    @apartments = current_user.apartments.order(:number)
  end

  # GET /apartments/1 or /apartments/1.json
  def show
  end

  # GET /apartments/new
  def new
    @apartment = current_user.apartments.new
  end

  # GET /apartments/1/edit
  def edit
  end

  # POST /apartments or /apartments.json
  def create
    @apartment = current_user.apartments.new(apartment_params)
    @apartment.user_id = current_user.id

    respond_to do |format|
      if @apartment.save
        flash[:notice] = "DEPARTAMENTO CREADO"
        format.html { redirect_to @apartment }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1 or /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        flash[:notice] = "DEPARTAMENTO ACTUALIZADO"
        format.html { redirect_to @apartment }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1 or /apartments/1.json
  def destroy
    @apartment.destroy!

    respond_to do |format|
      flash[:notice] = "DEPARTAMENTO ELIMINADO"
      format.html { redirect_to apartments_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = current_user.apartments.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apartment_params
      params.require(:apartment).permit(:number, :description, :user_id)
    end
end
