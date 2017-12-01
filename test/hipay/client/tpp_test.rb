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

      assert_not_nil response
      assert_equal response['order']['id'], "TEST-HPAYMENT-001"
      assert_equal response['order']['amount'], "74.12"
    end
  end

  def post_v1_order_success
    VCR.use_cassette("post_v1_order_success") do
      response = @hipay.post('v1/order', {
        orderid: "TEST-ORDER-001",
        operation: "Authorization",
        payment_product: "cb",
        description: "Desc test",
        amount: "72.13",
        accept_url: "http://test.com",
        decline_url: "http://test.com",
        pending_url: "http//test.com",
        exception_url: "http://test.com",
        cancel_url: "http://test.com",
        firstname: "Jane",
        lastname: "Doe",
        currency: "EUR"
      })

      # PENDING TEST - RESPONSE
      # {"code"=>"1020001", "message"=>"No route to acquirer", "description"=>nil}

      assert_not_nil response
      pending assert_equal response['order']['id'], "TEST-ORDER-001"
      pending assert_equal response['order']['amount'], "72.13"
    end
  end

  def test_get_v1_transaction_success
    VCR.use_cassette("get_v1_transaction_success") do
      response = @hipay.get("v1/transaction", {orderid: "TEST-ORDER-001"})

      assert_not_nil response
      assert_not_nil response['transaction']['transaction_reference']
      assert_equal response['transaction']['order']['id'], "TEST-ORDER-001"
    end
  end

  def test_get_v1_transaction_with_ref_success
    VCR.use_cassette("get_v1_transaction_with_ref_success") do
      transaction_ref = @hipay.get("v1/transaction", {orderid: "TEST-ORDER-001"})['transaction']['transaction_reference']
      response = @hipay.get("v1/transaction/#{transaction_ref}", {})

      assert_not_nil response
      assert_equal response['transaction']['transaction_reference'], transaction_ref
      assert_equal response['transaction']['order']['id'], "TEST-ORDER-001"
    end
  end

  def post_v1_maintenance_success
    VCR.use_cassette("post_v1_maintenance_success") do
      transaction_ref = @hipay.get("v1/transaction", {orderid: "TEST-ORDER-001"})['transaction']['transaction_reference']

      response = @hipay.post("v1/maintenance/transaction/#{transaction_ref}", {operation: "cancel"})

      # PENDING TEST - RESPONSE
      # {"code"=>"1020001", "message"=>"No route to acquirer", "description"=>nil}

      assert_not_nil response
      pending assert_equal response['order']['id'], "TEST-ORDER-001"
      pending assert_equal response['order']['amount'], "72.13"
    end
  end

  def get_v2_available_payment_products
    VCR.use_cassette("get_v2_available_payment_products_success") do
      response = @hipay.get("v2/available-payment-products", {})

      # PENDING TEST - RESPONSE
      # Incorrect Credentials

      assert_not_nil response
    end
  end
end
