class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def authenticate_user
    @current_user = Account.find_by(username: request.headers['username'], auth_id: request.headers['password'])
    if !@current_user.present?
      render :json => {:error => 'Authentication Failed'}.to_json, :status => 403
    end
  end
end
