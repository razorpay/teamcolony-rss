require 'minitest/autorun'
require 'webmock/minitest'

def fixture_file(filename = '')
  filename = "export" + (filename==''? '' : "_#{filename}")
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename + '.json')
  File.read(file_path)
end

def stub_response(filename = '', status = nil)
  response = { body: fixture_file(filename) }
  response.merge!(status: status) unless status.nil?
  response.merge!(headers: { 'Content-Type' => 'application/json' })
end

def stub_get(filename = '')
  response = stub_response(filename)
  stub_request(:get, /.*/).to_return(response)
end