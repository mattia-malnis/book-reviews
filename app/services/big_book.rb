require "net/http"
require "json"

class BigBook
  BASE_URL = "https://api.bigbookapi.com".freeze

  def list_books(offset = 0)
    list = fetch_remote_list(offset)
    {
      items: transform_items(list[:items]),
      quota_left: list[:quota_left]
    }
  end

  private

  def fetch_remote_list(offset = 0)
    response = fetch_json("/search-books?number=100&offset=#{offset}")
    {
      items: response[:items].dig("books"),
      quota_left: response[:quota_left]
    }
  end

  def transform_items(items)
    items.map do |item|
      {
        id: item[0]["id"],
        title: item[0]["title"],
        subtitle: item[0]["subtitle"],
        image_url: item[0]["image"]
      }
    end
  end

  def fetch_json(path)
    uri = URI("#{BASE_URL}#{path}")
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      request = Net::HTTP::Get.new(uri)
      request["x-api-key"] = ENV["BIGBOOK_API_KEY"]
      http.request(request)
    end

    handle_response(response, path)

  rescue StandardError => e
    handle_error(e, path)
  end

  def handle_response(response, path)
    if response.is_a?(Net::HTTPSuccess)
      {
        items: JSON.parse(response.body),
        quota_left: response["X-Api-Quota-Left"].to_i
      }
    else
      raise ApiError, "Failed to fetch data from #{path}: #{response.code} #{response.message}"
    end
  end

  def handle_error(error, path)
    case error
    when JSON::ParserError
      raise JsonParseError, "Failed to parse JSON from #{path}: #{error.message}"
    else
      raise ApiError, "Error fetching data from #{path}: #{error.message}"
    end
  end
end

class ApiError < StandardError; end
class JsonParseError < StandardError; end
