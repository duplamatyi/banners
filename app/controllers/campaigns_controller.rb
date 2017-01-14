class CampaignsController < ApplicationController
  def show
    redis = Redis.current
    banner_list_key = "banner-list:#{params[:id]}"
    banner_count = redis.llen banner_list_key
    if banner_count > 0
      # TODO: Remove this line if integration tests are aware of the session
      session['dsadsdasadd'] = 'dsdsadsad'
      view_count_key = "view_count:#{params[:id]}"
      view_count = session.id.nil? ? 0 : (redis.hget(view_count_key, session.id) || 0)
      @banner_id = redis.lindex(banner_list_key, view_count)
      redis.hset(view_count_key, session.id, (view_count.to_i + 1) % banner_count)
    else
      render status: :not_found
    end
  end
end
