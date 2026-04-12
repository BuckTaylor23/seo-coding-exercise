Given(/^a driver exists in the driver domain system$/) do
  artefacts.driver = DriverHelper.build_driver
  HttpRequestHelper.submit_request_to_endpoint(body: artefacts.driver)
end

When(/^the (.*) request is submitted( with the (?:existing|non-existing) DLN)?$/) do |request_type, _existing_driver|
  HttpRequestHelper.submit_request_to_endpoint(request_type: request_type)
end

Then(/^a (.*) response is returned$/) do |arg|
  expected_status_code = HttpStatusMapper.extract_status_code(arg)
  returned_status_code = artefacts.response.code

  expect(returned_status_code).to eq(expected_status_code),
                                  "Expected response status code to be #{expected_status_code}, but got: #{returned_status_code}"
end
