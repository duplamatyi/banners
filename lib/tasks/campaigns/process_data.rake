require 'redis'

namespace :'campaigns' do
  desc "Builds the list of top banners of each campaign."
  task :build_banner_list, [:path] => :environment do |task, args|
    path = args[:path].nil? ? Rails.root.join('assignment/data') : Pathname.new(args[:path])
    campaigns = Campaign::Reader.new.parse path
    banners = Campaign::Builder.new.build campaigns
    redis = Redis.new
    redis.flushdb
    banners.each do |campaign_id, banner_ids|
      redis.lpush campaign_id, banner_ids
    end
  end
end
