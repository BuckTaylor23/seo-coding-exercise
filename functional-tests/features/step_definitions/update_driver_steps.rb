And(/^an (?:update|delete) request (?:contains|is) (.*)$/) do |field|
  if field.downcase == 'any update fields'
    field = OPTIONAL_UPDATE_FIELDS.sample
  end

  artefacts.request_body = if field == 'empty'
                             {}
                           else
                             { field.to_sym => DriverHelper.driver_details_update(field) }
                           end
end

And(/^the driver record is updated successfully$/) do
  update_request = artefacts.request_body
  updated_driver = artefacts.response.deep_symbolize_keys

  expect(updated_driver).to include(update_request)
end

And(/^the driver record is unchanged$/) do
  current_record = DriverHelper.lookup_driver
  current_record.delete('id')

  expect(current_record.deep_symbolize_keys).to eq(artefacts.driver.as_json)
end
