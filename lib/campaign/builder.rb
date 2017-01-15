module Campaign
  class Builder
    # Builds the list of top x banners for each campaign based on data provided by
    # the Campaign::Reader.parse method.
    #
    # - +campaigns+: Campaign data structured as specified at the output format of
    # the Campaign::Reader.parse method.
    #
    # Returns a hash with the campaign ids as keys. The values of this list are the
    # banner ids of the top x banners in a random order. The top x banners are
    # determined the following way:
    # - if x > 10:    - the top 10 banners based on revenue
    # - if 5 < x <=10 - the top x banners based on revenue
    # - if 0 < x <=5  - the top x banners based on revenue
    #                 - banners with the most clicks to make up a collection of 5
    # - if x == 0     - the top 5 banners based on clicks
    #                 - random banners to make up a collection of 5
    def build(campaigns)
      banners = {}
      campaigns.each do |campaign_id, campaign|
        banners[campaign_id] = []

        # Create a list of banner hashes out of the original campaign hash so that it's
        # easily sortable by revenue and clicks.
        banner_list = campaign.map { |key, value| value.merge!({ banner_id: key }) }
        banner_list.sort_by! { |val| val[:revenue] }.reverse!

        # Pop maximum 10 banners with the highest revenue from the list.
        loop do
          break if banner_list.first[:revenue] == 0.0 || banners[campaign_id].length == 10
          banners[campaign_id]  << banner_list.shift[:banner_id]
        end

        # Until we have 5 banners pop the banners with the most clicks.
        if banners[campaign_id].length < 5
          banner_list.sort_by! { |val| val[:clicks] }.reverse!
          loop do
            break if banner_list.first[:clicks] == 0 || banners[campaign_id].length == 5
            banners[campaign_id]  << banner_list.shift[:banner_id]
          end
        end

        # Complete the list with random banners to have 5 banners.
        if banners[campaign_id].length < 5
          sample = banner_list.sample(5 - banners[campaign_id].length)
          banners[campaign_id].concat(sample.map { |banner| banner[:banner_id] })
        end

        banners[campaign_id].shuffle!
      end

      banners
    end
  end
end

