# frozen_string_literal: true

require 'active_any'
require 'slack-ruby-client'
require 'active_any/slack/version'
require 'active_any/slack/adapter.rb'

module ActiveAny
  module Slack
    class Configuration
      attr_writer :token

      def token
        @token ||= ENV['SLACK_TOKEN']
      end
    end

    def self.configure
      yield configuration if block_given?
    end

    def self.config
      @config ||= Configuration.new
    end

    class User < ActiveAny::Base
      self.abstract_class = true

      class << self
        def adapter
          Slack::Adapter.new(self, :users_list)
        end
      end
    end
  end
end
