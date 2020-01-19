class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_genres

	def after_sign_in_path_for(resource)
		case resource
			when User
				root_path
			when Admin
				admin_genres_path
		end
	end

	def after_sign_up_path_for(resource)
		case resource
			when User
				root_path
			when Admin
				admin_genres_path
		end
	end


	protected

	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def set_genres
  	@genres = Genre.all
  end
end
