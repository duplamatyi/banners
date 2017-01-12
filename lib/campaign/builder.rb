module Campaign
  class Builder
    def build campaigns
      banners = {}
      campaigns.each do |campaign_id, campaign|
        banners[campaign_id] = []
        campaign_list = campaign.map { |key, value| value.merge!({banner_id: key}) }
        campaign_list.sort_by! { |val| val[:revenue] }.reverse!
        loop do
          break if campaign_list.first[:revenue] == 0.0 || banners[campaign_id].length == 10
          banners[campaign_id]  << campaign_list.shift[:banner_id]
        end

        if banners[campaign_id].length < 5
          campaign_list.sort_by! { |val| val[:clicks] }.reverse!
          loop do
            break if campaign_list.first[:clicks] == 0 || banners[campaign_id].length == 5
            banners[campaign_id]  << campaign_list.shift[:banner_id]
          end
        end

        if banners[campaign_id].length < 5
          sample = campaign_list.sample(5 - banners[campaign_id].length)
          banners[campaign_id].concat(sample.map { |banner| banner[:banner_id] })
        end

        banners[campaign_id].shuffle!
      end

      banners
    end
  end
end

