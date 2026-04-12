Given(/^a valid request contains the following fields:$/) do |table|
  given_fields = table.raw.flatten
  artefacts.request_body = DriverHelper.build_driver_with(given_fields)
end

Given(/^a request where the (\S+) field is (.*)$/) do |field, condition|
  value = case condition.downcase
          when 'missing' then nil
          when 'empty' then ''
          when 'overlength' then Faker::Lorem.characters(number: 33)
          when 'wrong format' then Faker::Date.between(from: Date.today.prev_year(100), to: Date.today.prev_year(17)).strftime('%d-%m-%Y')
          when 'invalid' then Faker::Lorem.word
          else
            raise "Unknown field condition: #{condition}"
          end
  artefacts.request_body = DriverHelper.build_driver_from_override(field, value)
end

Given(/^a request where the (\S+) field contains (.+)$/) do |field, value|
  artefacts.request_body = DriverHelper.build_driver_from_override(field, value)
end

And(/^the response contains the correct driver record$/) do
  requested_driver = artefacts.driver || artefacts.request_body
  req_body = requested_driver.as_json.deep_symbolize_keys
  res_body = artefacts.response.as_json.deep_symbolize_keys

  aggregate_failures('Assert correct driver details returned') do
    expect(req_body[:first_names]).to eq(res_body[:first_names])
    expect(req_body[:last_name]).to eq(res_body[:last_name])
    expect(req_body[:date_of_birth]).to eq(res_body[:date_of_birth])
    expect(req_body[:driving_licence_type]).to eq(res_body[:driving_licence_type])
  end
end

And(/^the driver licence number is generated correctly$/) do
  driver_details = artefacts.request_body.as_json.deep_symbolize_keys
  generated_dln = artefacts.response.as_json.deep_symbolize_keys[:driving_licence_number]
  expected_dln = DriverHelper.generate_dln_from(driver_details)

  expect(generated_dln[0..-3]).to eq(expected_dln),
                                  "Expected driver DLN to match: #{expected_dln}, but got: #{generated_dln}"
end

Given(/^a request contains a driver (.*)$/) do |age|
  if age == 'under 17'
    artefacts.request_body = DriverHelper.build_driver_from_override('date_of_birth', (Date.today.prev_year(17) + 1).to_s)
  elsif age == 'over 100'
    artefacts.request_body = DriverHelper.build_driver_from_override('date_of_birth', (Date.today.prev_year(100) - 1).to_s)
  else
    raise "Unknown age condition: #{age}"
  end
end
