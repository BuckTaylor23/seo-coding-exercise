# frozen_string_literal: true

module HttpStatusMapper
module_function

  STATUS_CODE_LENGTH = 3

  def extract_status_code(http_status_code_text)
    status_code = http_status_code_text[0, STATUS_CODE_LENGTH].to_i

    unless Rack::Utils::HTTP_STATUS_CODES.has_key?(status_code)
      raise ArgumentError, 'Status code unrecognised, please double check test input and try again.'
    end

    status_code
  end
end
