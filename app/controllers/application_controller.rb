class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  set_current_tenant_through_filter # <-- ESTA ES LA LÍNEA CLAVE

  before_action :set_current_user_as_tenant, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :selected_year, :selected_year?

  def authorize_request(kind = nil)
    unless kind.include?(current_user.role)
      flash[:alert] = "NO ESTÁ AUTORIZADO PARA REALIZAR ESTA ACCION"
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

  def set_current_user_as_tenant
    set_current_tenant(current_user) if user_signed_in?
  end

  private

  def require_year
    if user_signed_in? && !session[:selected_year].present?
      flash[:alert] = "Debes seleccionar un año antes de continuar."
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
end
