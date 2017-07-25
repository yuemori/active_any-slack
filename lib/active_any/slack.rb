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

    class Base < ActiveAny::Base
      self.abstract_class = true

      class << self
        attr_accessor :api_name
        attr_reader :param_keys

        def json_file=(file)
          json = JSON.parse(File.read(File.expand_path(file, File.dirname(__FILE__))))
          @param_keys = json['args'].keys
        end

        def adapter
          Slack::Adapter.new(self, api_name, param_keys)
        end
      end
    end

    class User < ActiveAny::Slack::Base
      self.api_name = :users_list
      self.json_file = 'slack/slack-api-ref/methods/users/users.list.json'

      attributes :id, :team_id, :name, :deleted, :color, :real_name,
                 :tz, :tz_label, :tz_offset, :profile, :is_admin, :is_owner,
                 :updated, :has_2fa, :is_bot, :is_primary_owner, :is_restricted,
                 :is_ultra_restricted
    end
  end
end
