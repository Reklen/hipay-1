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
        define_method method do |path, attrs|
          if has_body
            query method, path(path), attrs
          else
            query method, path(path, attrs)
          end
        end
      end


      private

      def path path, attrs = {}
        path = [@uri.request_uri, path].join('/')
        if attrs.present?
          [path, URI.encode_www_form(attrs)].join('?')
        else
          path
        end
      end

      def query(method, path, attrs = {})
        req = "Net::HTTP::#{method.to_s.capitalize}".constantize.new path(path, attrs)

        req.set_form_data attrs unless attrs.blank?

        req.basic_auth(@options[:username], @options[:password])

        handle_response @http.request(req)
      end

      def handle_response response
        response.read_body.from_json
      end

    end

  end
end
