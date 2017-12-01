require "net/https"
require 'uri'

module Hipay
  class Client
    class TPP

      def initialize opts = {}
        @options = opts.with_indifferent_access
        @uri = URI.parse @options.delete :url
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true if @uri.port == 443
      end

      {
        post: true,
        put: true,
        patch: true,
        delete: false,
        get: false
      }.each do |method, has_body|
        define_method method do |url, attrs|
          if has_body
            query method, get_path(url), attrs
          else
            query method, get_path(url, attrs)
          end
        end
      end

      def get_path url, attrs = {}
        full_path = [@uri.request_uri, url].join('/')
        if attrs.present?
          return [full_path, URI.encode_www_form(attrs)].join('?')
        else
          return full_path
        end
      end

      def query(method, full_path, attrs = {})
        req = "Net::HTTP::#{method.to_s.capitalize}".constantize.new full_path

        req.set_form_data attrs unless attrs.blank?

        req.basic_auth(@options[:username], @options[:password])

        handle_response @http.request(req)
      end

      def handle_response response
        response.read_body
      end


    end

  end
end
