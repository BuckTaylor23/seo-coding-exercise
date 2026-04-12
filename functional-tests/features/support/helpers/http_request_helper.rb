# frozen_string_literal: true

module HttpRequestHelper
module_function

  def submit_request_to_endpoint(request_type: 'create driver', body: artefacts.request_body)
    base_url = Settings.endpoint.base_url
    api_path = Settings.endpoint.api_path
    endpoint_url = if request_type == 'create driver'
                     "#{base_url}#{api_path}"
                   else
                     "#{base_url}#{api_path}/#{DriverHelper.value_from_driver('driving_licence_number')}"
                   end

    http_method = determine_http_method(request_type)

    LOG.info { "Submitting #{request_type} request#{body ? " with body: #{body.as_json}" : ''} to #{endpoint_url}".cyan }

    artefacts.response = HTTP_METHODS[http_method].call(endpoint_url,
                                                        headers: { 'Content-Type' => 'application/json' },
                                                        body: body.to_json)
  end

  def determine_http_method(request_type)
    case request_type.downcase
    when 'create driver' then 'post'
    when 'retrieve driver' then 'get'
    when 'update driver' then 'patch'
    when 'delete driver' then 'delete'
    else
      raise "Unknown request type: #{request_type}"
    end
  end
end
