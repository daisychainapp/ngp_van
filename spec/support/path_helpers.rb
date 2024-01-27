# frozen_string_literal: true

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture(file)
  File.new("#{fixture_path}/#{file}")
end
