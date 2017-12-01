require 'active_support/core_ext/hash'
require 'active_support/json'
require 'hipay/client'
require 'hipay/client/soap'
require 'hipay/client/tpp'

module Hipay

  TPP_TEST_URL = "https://stage-secure-gateway.hipay-tpp.com/rest/"
  TPP_PROD_URL = "https://secure-gateway.hipay-tpp.com/rest/"

end
