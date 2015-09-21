require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'hipay'

# It can be initialized
fail unless Hipay::Client.new
