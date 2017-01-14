class CampaignsController < ApplicationController
  def show
    redis = Redis.current
    banner_list_key = "banner-list:#{params[:id]}"
    count = redis.llen banner_list_key
    if count > 0
      session_key = "campaign#{params[:id]}"
      session[session_key] ||= 0
      @banner_id = redis.lindex(banner_list_key, session[session_key])
      session[session_key] = (session[session_key] + 1) % count
    else
      render status: :not_found
    end
  end
end
