require 'active_support/core_ext/hash'
require 'active_support/json'

require 'hipay/client'

require 'hipay/concerns/rest_api'

require 'hipay/client/soap'
require 'hipay/client/tokenization'
require 'hipay/client/tpp'


module Hipay

  GATEWAY_TEST_URL = "https://stage-secure-gateway.hipay-tpp.com/rest"
  GATEWAY_PROD_URL = "https://secure-gateway.hipay-tpp.com/rest"

  TOKENIZATION_TEST_URL = "https://stage-secure2-vault.hipay-tpp.com/rest/v2/token"
  TOKENIZATION_PROD_URL = "https://secure2-vault.hipay-tpp.com/rest/v2/token"

end
