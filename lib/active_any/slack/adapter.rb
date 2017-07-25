# frozen_string_literal: true

module ActiveAny
  module Slack
    class Adapter < ActiveAny::ObjectAdapter
      attr_reader :api_name

      def initialize(klass, api_name)
        super(klass)
        @api_name = api_name
      end

      def query(where_clause: Relation::WhereClause.empty, order_clause: Relation::OrderClause.empty, limit_value: nil, group_values: [])
        records = fetch_records(limit_value)
        records = where_handler(records, where_clause)
        records = group_handler(records, group_values)
        records = order_handler(records, order_clause)
        records
      end

      def order_handler(records, order_clause)
        raise NotImplementedError.new, 'ActiveAny::Slack not supported to reverse order' if order_clause.reverse?
        super
      end

      private

      def fetch_records(limit_value)
        response = client.send(api_name, params.merge(limit: limit_value))
        response['members'].map { |member| klass.new(member.to_h) }
      end

      def params
        @params ||= {}
      end

      def client
        @client ||= ::Slack::Web::Client.new(token: ActiveAny::Slack.config.token)
      end
    end
  end
end
