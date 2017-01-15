class CampaignsController < ApplicationController
  # Displays a banner id for a given campaign id.
  # - First checks the index of the last displayed banner for a given user based
  #   on tha value stored in a hash in Redis.
  # - Than retrieves the id of the next banner from a list of banner ids from Redis.
  # - If the campaign has no banners it sets
  #   the 404 status code for the response.
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
