class ProcessDataTest < ActiveSupport::TestCase
  setup do
    ENV['REDIS_URL'] = 'redis://redis:6379/2'
    Campaign::Application.load_tasks
  end

  test "should push data to redis" do
    Rake::Task['campaign:build_banner_list'].invoke(Rails.root.join('test/data'))
  end
end
