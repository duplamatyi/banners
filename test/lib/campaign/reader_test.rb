class ReaderTest < ActiveSupport::TestCase
  setup do
    path = Rails.root.join('test/data')
    reader = Campaign::Reader.new
    @campaigns = reader.parse path
  end

  test "should create campaigns hash" do
    assert_equal %w(0 1), @campaigns.keys.sort
    assert_equal %w(0 1 2 3), @campaigns['0'].keys.sort
    assert_equal %w(0 1 2), @campaigns['1'].keys.sort
    assert @campaigns['0']['0'].key?(:clicks)
    assert @campaigns['0']['0'].key?(:revenue)
  end

  test "should count the clicks on a banner in a campaign" do
    assert_equal 0, @campaigns['0']['1'][:clicks]
    assert_equal 1, @campaigns['0']['0'][:clicks]
    assert_equal 4, @campaigns['1']['2'][:clicks]
  end

  test "should calculate the revenue for a banner in a campaign" do
    assert_in_delta @campaigns['0']['2'][:revenue], 3.0, 0.05
    assert_in_delta @campaigns['1']['1'][:revenue], 8.0, 0.05
    assert_in_delta @campaigns['1']['0'][:revenue], 0.0, 0.05
    assert_in_delta @campaigns['1']['2'][:revenue], 2.5, 0.05
  end
end
