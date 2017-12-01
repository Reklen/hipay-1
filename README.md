# Hipay

Provide Cash Out and TPP integration clients

## Installation

Add this line to your application's Gemfile:

    gem 'hipay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hipay

## Usage

Refer to the hipay documentation for each client specific usage and endpoints

### Cash out client (SOAP)


```ruby
client = Hipay::Client.new base_url: "https://test-ws.hipay.com/soap",
   wsLogin: "my_login",
   wsPassword: "my_password",
   entity: "my_entity"

client.user_account.operations
=> [:send_activation_mail,
 :create,
 :create_with_website,
 :create_full_user_account,
 :is_available,
 :get_available_payment_methods,
 :get_balance,
 :get_transactions,
 :bank_infos_check,
 :bank_infos_fields,
 :bank_infos_status,
 :bank_infos_register,
 :get_account_infos,
 :associate_merchant_group,
 :create_subaccount,
 :set_merchant_notification_in_post,
 :set_merchant_token_in_notification]

client.transfer.operations
=> [:direct]

client.withdrawal.operations
=> [:create]
```


Before to call the hipay webservice, the method name and the params passed to the client are camelized
The response is then extracted from its enveloppe, hashified and underscorized

```ruby
client.user_account.call :is_available, email: 'test_test@gmail.com'
=> {"description"=>"Email available : test_test@gmail.com", "is_available"=>true}
```

On Hipay webservice error, raise a Hipay::Client::SOAP::Error exception
```ruby
client.user_account.call :is_available, email: ''
=> Hipay::Client::SOAP::Error: Code 3 : invalid parameter email
```

### TPP client (REST)

Checkout out https://developer.hipay.com/doc-api/enterprise/gateway/#/

```ruby
tpp_client = Hipay::Client::TPP.new username: "my_login", password: "my_password"
By default, env_test is set to false, set it to true for production mode!

tpp_client.post('v1/hpayment', {orderid: "TEST-HPAYMENT-001", operation: "Authorization", description: "Desc test", amount: "70", accept_url: "http://test.com", decline_url: "http://test.com", pending_url: "http//test.com", exception_url: "http://test.com", cancel_url: "http://test.com", firstname: "Jane", lastname: "Doe", currency: "EUR"})

tpp_client.post('v1/order', {orderid: "TEST-ORDER-001", operation: "Authorization", payment_product: "cb", description: "Desc test", amount: "70", accept_url: "http://test.com", decline_url: "http://test.com", pending_url: "http//test.com", exception_url: "http://test.com", cancel_url: "http://test.com", firstname: "Jane", lastname: "Doe", currency: "EUR"})

tpp_client.post("v1/maintenance/transaction/#{transaction_id}", {operation: "cancel"})0

tpp_client.get("v1/transaction", orderid: "TEST-ORDER-001")
tpp_client.get("v1/transaction/#{transaction_id}", {})

tpp_client.get('v2/available-payments-products', {})

```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/hipay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
