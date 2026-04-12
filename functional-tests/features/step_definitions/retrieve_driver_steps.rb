Given(/^a request contains non existing driver$/) do
  artefacts.driver = { driving_licence_number: DriverHelper.generate_random_dln }
end

And(/^the response contains the (error|errors)?:$/) do |type, table|
  expected = table.hashes.map { |h| h[type] }
  actual = Array(artefacts.response.deep_symbolize_keys[type.to_sym])

  expect(actual).to eq(expected),
                    "Expected response to contain #{type}: #{expected}, but got: #{actual}"
end
