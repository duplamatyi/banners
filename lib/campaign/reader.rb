require 'csv'

module Campaign
  class Reader
    def parse(path)
      options = {headers: :first_row, skip_blanks: true}

      campaigns = {}
      CSV.foreach(path.join('impressions.csv'), options) do |row|
        campaigns[row['campaign_id']] = {} unless campaigns.key? row['campaign_id']
        unless campaigns[row['campaign_id']].key? row['banner_id']
          campaigns[row['campaign_id']][row['banner_id']] = {
              clicks: 0,
              revenue: 0.0
          }
        end
      end

      clicks = {}
      CSV.foreach(path.join('clicks.csv'), options) do |row|
        campaigns[row['campaign_id']][row['banner_id']][:clicks] += 1
        clicks[row['click_id']] = {campaign_id: row['campaign_id'], banner_id: row['banner_id']}
      end

      CSV.foreach(path.join('conversions.csv'), options) do |row|
        banner_id = clicks[row['click_id']][:banner_id]
        campaign_id = clicks[row['click_id']][:campaign_id]
        campaigns[campaign_id][banner_id][:revenue] += row['revenue'].to_f
      end

      campaigns
    end
  end
end
