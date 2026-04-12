# frozen_string_literal: true

require 'grape'

class Drivers < Grape::API
  namespace :drivers do
    desc 'Create a driver'
    params do
      requires :first_names, type: String
      requires :last_name, type: String
      requires :date_of_birth, type: String
      requires :driving_licence_type, type: String
      optional :driving_licence_number, type: String
    end
    post do
      driver_params = declared(params, include_missing: false).symbolize_keys
      driver_params[:driving_licence_type] = driver_params[:driving_licence_type]&.capitalize

      schema = DriverSchema.new(driver_params)
      error!({ errors: schema.errors.full_messages }, 422) unless schema.valid?

      driver_params[:driving_licence_number] ||= Driver.generate_unique_licence_number(**driver_params)

      begin
        DB[:drivers].insert(driver_params)
      rescue Sequel::UniqueConstraintViolation
        error!({ error: 'Driving licence number already exists' }, 409)
      end

      status 201
      driver_params
    end

    desc 'Retrieve a driver'
    get ':driving_licence_number' do
      record = DB[:drivers].where(driving_licence_number: params[:driving_licence_number]).first
      error!({ error: 'Driver not found' }, 404) unless record

      record
    end

    desc 'Update a driver'
    params do
      optional :first_names, type: String
      optional :last_name, type: String
      optional :driving_licence_type, type: String
      at_least_one_of :first_names, :last_name, :driving_licence_type
    end
    patch ':driving_licence_number' do
      dataset = DB[:drivers].where(driving_licence_number: params[:driving_licence_number])
      record = dataset.first
      error!({ error: 'Driver not found' }, 404) unless record

      updates = declared(params, include_missing: false).symbolize_keys
      updates[:driving_licence_type] = updates[:driving_licence_type]&.capitalize if updates[:driving_licence_type]

      merged = record.except(:id).merge(updates)
      schema = DriverSchema.new(merged.slice(:first_names, :last_name, :date_of_birth, :driving_licence_type))
      error!({ errors: schema.errors.full_messages }, 422) unless schema.valid?

      # Update DLN if first or last names are changed.
      if updates[:first_names] || updates[:last_name]
        merged = record.except(:id).merge(updates)
        updates[:driving_licence_number] = Driver.generate_licence_number(**merged)
      end

      dataset.update(updates)
      DB[:drivers].where(driving_licence_number: updates[:driving_licence_number] || params[:driving_licence_number]).first
    end

    desc 'Delete a driver'
    params do
      requires :first_names, type: String
      requires :last_name, type: String
      requires :date_of_birth, type: String
    end
    delete ':driving_licence_number' do
      record = DB[:drivers].where(driving_licence_number: params[:driving_licence_number]).first
      error!({ error: 'Driver not found' }, 404) unless record

      %w[first_names last_name date_of_birth].each do |field|
        error!({ error: "#{field} does not match" }, 422) unless record[field.to_sym] == params[field].to_s
      end

      DB[:drivers].where(driving_licence_number: params[:driving_licence_number]).delete
      status 204
    end
  end
end
