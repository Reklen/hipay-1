module Hipay
  class Client
    def initialize opts = {}
      @options = opts.with_indifferent_access
      @clients = {}
    end

    def user_account namespace = 'user-account-v2'
      @clients[:user_account] ||= SOAP.new resource_options(namespace)
    end

    def transfer namespace = 'transfer'
      @clients[:transfer] ||= SOAP.new resource_options(namespace)
    end

    def withdrawal namespace = 'withdrawal'
      @clients[:withdrawal] ||= SOAP.new resource_options(namespace)
    end

    def transaction namespace = 'transaction-v2'
      @clients[:transaction] ||= SOAP.new resource_options(namespace)
    end

    def check_response *args, &block
      user_account.check_response(*args, &block)
    end

    private

    def resource_options namespace
      opts = @options.dup
      opts[:wsdl] = File.join opts.delete(:base_url), "#{namespace}?wsdl"
      opts
    end
  end
end
