class Api::SmsController < ApplicationController
  before_action :authenticate_user, only: [:inbound, :outbound]
  before_action :validate_params, only: [:inbound, :outbound]
  before_action :check_for_rate_limit, only: [:outbound]

  def inbound
    begin
      if !@current_user.phone_numbers.where(number: params[:to]).present?
        render :json => {error: "to parameter not found", message: ""}.to_json, :status => 200 and return
      else
        if(["STOP","STOP\n", "STOP\r","STOP\r\n"].include?(params[:text]))
          RedisCache.write("#{params[:from]}_#{params[:to]}", params[:text])
        end
        render :json => {error: "", message: "inbound sms ok"}.to_json, :status => 200 and return
      end
    rescue
      render :json => {error: "unknown failure", message: ""}.to_json, :status => 200 and return
    end
  end

  def outbound
    begin
      if !@current_user.phone_numbers.where(number: params[:from]).present?
        render :json => {error: "from parameter not found", message: ""}.to_json, :status => 200 and return
      elsif RedisCache.exist?("#{params[:from]}_#{params[:to]}")
        render :json => {error: "sms from #{params[:from]} to #{params[:to]}  blocked by STOP request", message: ""}.to_json, :status => 200 and return
      else
        render :json => {error: "", message: "outbound sms ok"}.to_json, :status => 200 and return
      end
    rescue
      render :json => {error: "unknown failure", message: ""}.to_json, :status => 200 and return
    end
  end

  def validate_params
    missing_params = ['from', 'to', 'text'] - params.keys
    if missing_params.present?
      render :json => {error: "#{missing_params.join(", ")} missing", message: "" }.to_json, :status => 200 and return
    end

    invalid_params = []
    invalid_params << "from" if params[:from].length < 6 || params[:from].length > 16
    invalid_params << "to" if params[:from].length < 6 || params[:from].length > 16
    invalid_params << "text" if params[:from].length < 1 || params[:from].length > 120
    if invalid_params.present?
      render :json => {error: "#{invalid_params.join(", ")} invalid", message: "" }.to_json, :status => 200 and return
    end
  end

  def check_for_rate_limit
    count = RedisCache.read_rl(params[:from])
    if count.to_i >= 50
      render :json => {error: "limit reached for from #{params[:from]}", message: ""}.to_json, :status => 200 and return
    else
      RedisCache.write_rl(params[:from], count.to_i+1)
    end
  end
end