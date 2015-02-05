require 'httparty'

RATING_HAPPY = 1

def get_satisfaction
  uri = "https://#{ENV['ZD_HOST']}/satisfaction.json"
  api_response = HTTParty.get(uri)
  JSON.parse(api_response.body)
end

SCHEDULER.every '60s', first_in: 0 do
  ratings = get_satisfaction
  overall_happiness = ratings.count(RATING_HAPPY).fdiv(ratings.size) * 100

  send_event 'zendesk-satisfaction', { overall_happiness: overall_happiness }
end

