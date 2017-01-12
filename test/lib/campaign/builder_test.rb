class BuilderTest < ActiveSupport::TestCase
  setup do
    build_cases
    builder = Campaign::Builder.new
    @banners = builder.build @campaigns
    @banners2 = builder.build @campaigns
  end

  test "should build banner list" do
    assert_equal 4, @banners.length
  end

  test "should get the top 10 banners when 10 < x" do
    assert_equal 10, @banners['0'].length
    assert_equal %w(0 1 10 2 3 4 5 6 7 9), @banners['0'].sort
  end

  test "should get the top x banners when 5 < x <= 10" do
    # banners = @builder.build @campaigns
    assert_equal 6, @banners['1'].length
    assert_equal %w(20 21 23 24 25 28), @banners['1'].sort
  end

  test "should get 5 banners containing the top x banners and the most clicked banners when 0 < x <=5 " do
    assert_equal 5, @banners['2'].length
    assert_equal %w(30 31 33 34 35), @banners['2'].sort
  end

  test "should get 5 banners consisting the most clicked banners and random banners when x = 0" do
    assert_equal 5, @banners['3'].length
    %w(41 43 44).each do |id|
      assert_includes @banners['3'], id
    end
  end

  test "should select banners in a random order" do
    assert_not_equal @banners['0'], @banners2['0']
  end

  test "should pick the banners with 0 clicks randomly" do
    rand_banners = @banners['3'].select{ |item| ! %w(41 43 44).include?(item) }
    rand_banners2 = @banners2['3'].select{ |item| ! %w(41 43 44).include?(item) }
    assert_not_equal rand_banners.sort, rand_banners2.sort
  end

  private

  def build_cases
    @campaigns = {}

    x_g_10
    x_g_5_le_10
    x_g_0_le_5
    x_e_0
  end

  def x_g_10
    @campaigns['0'] = {
        '0'  => { clicks: 34, revenue: 12.343443},
        '1'  => { clicks: 21, revenue: 20.732377},
        '2'  => { clicks: 33, revenue: 82.323323},
        '3'  => { clicks: 55, revenue: 50.321321},
        '4'  => { clicks: 11, revenue: 82.321323},
        '5'  => { clicks: 93, revenue: 91.321321},
        '6'  => { clicks: 10, revenue: 74.321312},
        '7'  => { clicks: 56, revenue: 41.321312},
        '8'  => { clicks: 57, revenue: 10.897842},
        '9'  => { clicks: 18, revenue: 41.321312},
        '10' => { clicks: 99, revenue: 28.312323},
        '11' => { clicks: 14, revenue: 0.0 },
        '12' => { clicks:  0, revenue: 0.0 }
    }
  end

  def x_g_5_le_10
    @campaigns['1'] = {
        '20' => { clicks: 12, revenue: 12.343443},
        '21' => { clicks: 21, revenue: 20.732377},
        '22' => { clicks: 41, revenue: 0.0 },
        '23' => { clicks: 55, revenue: 50.321321},
        '24' => { clicks: 11, revenue: 82.321323},
        '25' => { clicks: 93, revenue: 91.321321},
        '26' => { clicks: 11, revenue: 0.0 },
        '27' => { clicks:  0, revenue: 0.0 },
        '28' => { clicks: 33, revenue: 82.323323}
    }
  end

  def x_g_0_le_5
    @campaigns['2'] = {
        '30' => { clicks: 14, revenue: 11.343443},
        '31' => { clicks: 21, revenue: 40.732377},
        '32' => { clicks:  1, revenue: 0.0 },
        '33' => { clicks: 55, revenue: 50.321321},
        '34' => { clicks: 49, revenue: 0.0 },
        '35' => { clicks: 22, revenue: 32.323323},
        '36' => { clicks: 23, revenue: 0.0 }
    }
  end

  def x_e_0
    @campaigns['3'] = {
        '40' => { clicks:  0, revenue: 0.0 },
        '41' => { clicks: 21, revenue: 0.0 },
        '42' => { clicks:  0, revenue: 0.0 },
        '43' => { clicks: 55, revenue: 0.0 },
        '44' => { clicks: 33, revenue: 0.0 },
        '46' => { clicks:  0, revenue: 0.0 },
        '47' => { clicks:  0, revenue: 0.0 },
        '48' => { clicks:  0, revenue: 0.0 },
        '49' => { clicks:  0, revenue: 0.0 },
        '50' => { clicks:  0, revenue: 0.0 },
        '51' => { clicks:  0, revenue: 0.0 },
    }
  end
end
