# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ msg: e.record.errors.full_messages.first }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |_e|
      json_response({ msg: '找不到资源' }, :not_found)
    end
  end
end
