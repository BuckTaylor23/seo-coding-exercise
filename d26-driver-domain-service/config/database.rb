# frozen_string_literal: true

require 'sequel'

DB = Sequel.connect('sqlite://drivers.db')

DB.create_table? :drivers do
  primary_key :id
  String :driving_licence_number, unique: true, null: false
  String :first_names, null: false
  String :last_name, null: false
  String :date_of_birth, null: false
  String :driving_licence_type, null: false
end
