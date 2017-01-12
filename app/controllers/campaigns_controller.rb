class CampaignsController < ApplicationController
  def show
    redis = Redis.new
    count = redis.llen params[:id]
    if count > 0
      session_key = "campaign#{params[:id]}"
      session[session_key] ||= 0

      @banner_id = redis.lindex(params[:id], count - session[session_key] - 1)

      if session[session_key] < count
        session[session_key] += 1
      else
        session[session_key] = 0
      end
    else
      @banner_id = 'Not Found'
    end
  end
end
