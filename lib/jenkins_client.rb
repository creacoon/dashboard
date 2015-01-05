require 'net/http'
require 'uri'
require 'json'

class JenkinsClient
  def initialize(host, username, token)
    @host     = host
    @username = username
    @token    = token
  end

  def get_jobs(view: nil)
    fail ArgumentError, 'Missing view parameter' if view.nil?
    request("/view/#{view}")['jobs']
  end

  private

  def request(path)
    encoded_path = URI.encode(path)
    uri = URI.parse("#{@host}#{encoded_path}/api/json")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    req = Net::HTTP::Get.new(uri.request_uri)
    req.basic_auth(@username, @token)

    JSON.parse(http.request(req).body)
  end
end
