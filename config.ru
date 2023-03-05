# frozen_string_literal: true

require 'rack'
require 'polars'

ACCESS_DENIED_RESPONSE = [403, {'Content-Type' => 'text/plain'}, ['Access Denied']]

class RackApp
  def call(env)
    return ACCESS_DENIED_RESPONSE if env['HTTP_API_KEY'] != ENV['API_KEY']

    table = Polars.read_csv(env['rack.input'], has_header: true)
    table = table.with_column((table['user_id'] * table['app_id']).alias('result'))

    [200, {'Content-Type' => 'application/csv'}, [table.to_csv]]
  end
end

run RackApp.new
