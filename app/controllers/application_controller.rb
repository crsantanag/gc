class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_year, if: :year_required_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :selected_year, :selected_year?

  def authorize_request
    unless current_user.admin?
      flash[:alert] = "NO ESTÁ AUTORIZADO PARA REALIZAR ESTA ACCIÓN"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :role ])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  def require_year
    if user_signed_in? && !session[:selected_year].present?
      flash[:alert] = "SE DEBE SELECCIONAR UN AÑO ANTES DE CONTINUAR"
      redirect_to root_path
    end
  end

  def selected_year
    session[:selected_year]
  end

  def selected_year?
    session[:selected_year].present?
  end

  def year_selector_page?
    controller_name == "pages" && action_name == "index"
  end

  def year_required_controller?
    %w[deposits bills balance].include?(controller_name)
  end
end
