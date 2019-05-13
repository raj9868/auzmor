class ErrorsController < ActionController::Base

  def not_found
    render :json => {error: 'Invalid method'}.to_json, :status => 405 and return
  end
end