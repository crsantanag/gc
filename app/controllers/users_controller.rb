class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    user_params_to_update = user_params

    # Solo actualiza password si se proporcionó
    if user_params[:password].blank?
      user_params_to_update = user_params.except(:password, :password_confirmation)
    end

    if @user.update(user_params_to_update)
      flash[:notice] = "USUARIO ACTUALIZADO"
      redirect_to users_path, notice: "Usuario actualizado correctamente."
    else
      flash.now[:alert] = "ERROR AL ACTUALIZAR"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "NO ES POSIBLE ELIMINAR TU CUENTA"
      redirect_to users_path, alert: "No puedes eliminarte a ti mismo."
    else
      @user.destroy
      flash[:notice] = "USUARIO ELIMINADO"
      redirect_to users_path, notice: "Usuario eliminado."
    end
  end

  private

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "NO ESTÁ AUTORIZADO PARA ACCEDER A ESTA SECCIÓN"
      redirect_to root_path, alert: "No estás autorizado para acceder a esta sección."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name_community, :type_community, :saldo_inicial, :name, :email, :role, :password, :password_confirmation)
  end
end
