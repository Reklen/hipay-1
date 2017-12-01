require 'test_helper'

class TPP < Test::Unit::TestCase

  def setup
    @hipay = Hipay::Client::TPP.new(username: ENV['HIPAY_USERNAME'], password: ENV['HIPAY_PASSWORD'])
  end

  def test_initialization
      assert_not_nil @hipay
  end

  def test_post_v1_hpayment_success
    VCR.use_cassette("post_v1_hpayment_success") do
      response = @hipay.post('v1/hpayment', {
        orderid: "TEST-HPAYMENT-001",
        operation: "Authorization",
        description: "Desc test",
        amount: "74.12",
        accept_url: "http://test.com",
        decline_url: "http://test.com",
        pending_url: "http//test.com",
        exception_url: "http://test.com",
        cancel_url: "http://test.com",
        firstname: "Jane",
        lastname: "Doe",
        currency: "EUR"
      })

      puts response

      assert_not_nil response
      assert_equal response['order']['id'], "TEST-HPAYMENT-001"
      assert_equal response['order']['amount'], "74.12"
    end
  end

end
