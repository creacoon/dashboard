require 'open-uri'
require 'date'
require 'cgi'
require 'icalendar'
require 'net/http'

class Calendar < Dashing::Job

  def do_execute
    calendar_url = ENV['CALENDAR']

    events = get_todays_events_from_calendar calendar_url
    text = events_to_text events

    { events: text }
  end

  private

  def get_todays_events_from_calendar url
    calendar = Icalendar.parse(open(url))
    events = calendar.first.events.sort { |a,b| b.dtstart <=> a.dtstart }

    events.each_with_object([]) do |event, summaries|
      if DateTime.now.between?(event.dtstart, event.dtend)
        summaries.push(event.summary)
      end
    end
  end

  def events_to_text events
    events.join(" -- ")[0, 40]
  end
end
