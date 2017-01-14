namespace :'campaigns' do
  desc "Builds the list of top banners of each campaign."
  task :process_data, [:path] => :environment do |task, args|
    path = args[:path].nil? ? Rails.root.join('assignment/data') : Pathname.new(args[:path])
    campaigns = Campaign::Reader.new.parse path
    banners = Campaign::Builder.new.build campaigns
    redis = Redis.current
    redis.flushdb
    banners.each do |campaign_id, banner_ids|
      redis.lpush "banner-list:#{campaign_id}", banner_ids
    end
  end
end
