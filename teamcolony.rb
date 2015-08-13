require 'httparty'
require 'pp'
require 'dalli'

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
    @cache = Dalli::Client.new
  end

  def make_path(start_date, end_date)
    path = "/teams/#{@team_name}/reports"

    if start_date
      path += "/from/#{start_date}"
    end

    if end_date
      path += "/to/#{end_date}"
    end

    path+="/export.json"
  end

  def fetch(start_date = nil, end_date = nil)
    path = make_path(start_date, end_date)
    reports  = @cache.get(path)

    return reports if reports

    response = self.class.get path, @options
    reports = response['team']['reports'] || []
    @cache.set path, reports, 3600

    reports
  end
end