require 'savon'
require 'digest'

module Hipay
  class Client
    class SOAP

      def initialize opts
        @options = opts.with_indifferent_access
        @client = Savon.client wsdl: @options.delete(:wsdl)
      end

      def call method, params, opts= {}, &block
        response = @client.call method, opts.update(:message => { :parameters => @options.merge(params)}), &block
        hash = parse_response response, method
        code = hash.delete(:code).to_i
        if code > 0
          raise Error.new "Code #{code} : #{hash[:description]}"
        else
          hash
        end
      end

      def parse_response response, method
        response.body[:"#{method}_response"][:"#{method}_result"].with_indifferent_access
      rescue StandardError => e
        # binding.pry
        raise e
      end

      def build_request method, params, opts= {}, &block
        @client.build_request method, opts.update(:message => { :parameters => @options.merge(params)}), &block
      end

      def method_missing name, *params, &block
        if @client.respond_to? name
          @client.send name, *params, &block
        else
          super
        end
      end

      def check_response xml, opts = {}, &block
        hash = Hash.from_xml(xml.gsub(/(\n|\t)+\s*/,'')).with_indifferent_access

        md5_base = []
        md5_base << xml.match(/<result>.*<\/result>/m)[0]
        md5_base <<  @options[:wsPassword] unless opts.with_indifferent_access.key?(:content_only)

        unless hash[:notification][:md5content] == Digest::MD5.hexdigest(md5_base.join)
          raise BadChecksumError, hash
        end

        if block_given?
          block.call(hash[:notification][:result])
        else
          true
        end

      end

      class Error < StandardError; end
      class BadChecksumError < Error; end

    end
  end
end
