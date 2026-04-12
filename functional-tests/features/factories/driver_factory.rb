# frozen_string_literal: true

FakerMaker.factory :driver do
  driver_details(omit: :always) do
    first_names = Faker::Name.name_with_middle.tr('.', '')
    last_name = Faker::Name.last_name
    date_of_birth = Faker::Date.between(from: Date.today.prev_year(100), to: Date.today.prev_year(17))

    { first_names: first_names, last_name: last_name, date_of_birth: date_of_birth }
  end

  first_names(omit: :nil) { driver_details[:first_names] }
  last_name(omit: :nil) { driver_details[:last_name] }
  date_of_birth(omit: :nil) { driver_details[:date_of_birth].to_s }
  driving_licence_type(omit: :nil) { %w[Provisional Full].sample }
  driving_licence_number(omit: :nil) { DriverHelper.generate_dln_from(driver_details) }
end
