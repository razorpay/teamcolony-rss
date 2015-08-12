require 'httparty'
require 'pp'

class TeamColony
  include HTTParty

  base_uri 'www.teamcolony.com'

  def initialize
    @team_name   = ENV['TEAM_NAME']
    @options = {
      :headers => {
        "Cookie" => "_teamcolony_new_session=#{ENV['COOKIE']}; locale=en"
      }
    }
  end

  def fetch(start_date = nil, end_date = nil)
    path = "/teams/#{@team_name}/reports"
    if start_date
      path += "/from/#{start_date}"
    end
    if end_date
      path += "/to/#{end_date}"
    end
    path+="/export.json"

    response = self.class.get path, @options
    response['team']['reports'] || []
  end
end