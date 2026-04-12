And(/^a delete record request contains the correct fields$/) do
  artefacts.request_body = DriverHelper.map_record_for_deletion
end

And(/^a delete record request does not contain the correct fields$/) do
  artefacts.request_body = DriverHelper.map_record_for_deletion(incorrect_record: true)
end

And(/^the driver record is removed from the database$/) do
  retrieval_response = DriverHelper.lookup_driver

  expect(retrieval_response.code).to eq(404)
  expect(retrieval_response['error']).to eq('Driver not found')
end
