class CampaignsController < ApplicationController
  def show
    redis = Redis.new
    count = redis.llen params[:id]
    if count > 0
      session_key = "campaign#{params[:id]}"
      session[session_key] ||= 0
      @banner_id = redis.lindex(params[:id], session[session_key])
      session[session_key] = (session[session_key] + 1) % 10
    else
      render status: :not_found
    end
  end
end
