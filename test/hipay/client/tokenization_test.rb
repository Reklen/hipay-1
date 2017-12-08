require 'test_helper'

class Tokenization < Test::Unit::TestCase
   # https://developer.hipay.com/doc-api/enterprise/token/

  def setup
    @hipay = Hipay::Client::Tokenization.new(username: ENV['HIPAY_USERNAME'], password: ENV['HIPAY_PASSWORD'])
  end

  def test_initialization
      assert_not_nil @hipay
  end

  def test_post_v2_token_create
    VCR.use_cassette("post_v2_token_create_success", :record => :new_episodes) do
      response = @hipay.post('create', {
        card_number: "4000000000000002",
        card_expiry_month: "12",
        card_expiry_year: "2025",
        card_holder: "Jane Doe",
        cvc: "123"
      })

      assert_not_nil response
      assert_not_nil response['token']
      assert_equal response['brand'], "VISA"
      assert_equal response['card_holder'], "Jane Doe"
    end
  end

  def test_get_v2_token
    VCR.use_cassette("post_v2_token_get_success", :record => :new_episodes) do
      create_token = @hipay.post('create', {
        card_number: "4000000000000002",
        card_expiry_month: "12",
        card_expiry_year: "2025",
        card_holder: "Jane Doe",
        cvc: "123"
      })
      token = create_token['token']
      request_id = create_token['request_id']

      response = @hipay.get(token, {request_id: request_id})

      assert_not_nil response
      assert_equal response['token'], token
      assert_equal response['request_id'], request_id
      assert_equal response['brand'], "VISA"
    end
  end

  def test_post_v2_token_update
    VCR.use_cassette("post_v2_token_update_success", :record => :new_episodes) do
      create_token = @hipay.post('create', {
        card_number: "4000000000000002",
        card_expiry_month: "12",
        card_expiry_year: "2025",
        card_holder: "Jane Doe",
        cvc: "123"
      })
      token = create_token['token']
      request_id = create_token['request_id']

      response = @hipay.post("update", {request_id: request_id,
        card_token: token,
        card_expiry_year: "2099",
        card_expiry_month: "02",
        card_holder: "John Doe"
      })

      assert_not_nil response
      assert_equal response['request_id'], request_id
      assert_equal response['card_expiry_year'], "2099"
      assert_equal response['card_expiry_month'], "02"
    end
  end

end
