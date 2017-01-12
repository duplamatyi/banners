class ProcessDataTest < ActiveSupport::TestCase
  setup do
    Campaign::Application.load_tasks
  end

  test "should push data to redis" do
    Rake::Task['campaign:build_banner_list'].invoke(Rails.root.join('test/data'))
  end
end
