# frozen_string_literal: true

module ActiveAny
  module Slack
    class Adapter < ActiveAny::ObjectAdapter
      attr_reader :api_name, :param_keys

      def initialize(klass, api_name, param_keys)
        super(klass)
        @api_name = api_name
        @param_keys = param_keys
      end

      def query(where_clause: Relation::WhereClause.empty, order_clause: Relation::OrderClause.empty, limit_value: nil, group_values: [])
        params = where_clause.conditions.map(&:to_h).inject({}, :merge!).slice(*param_keys).merge(limit: limit_value)
        records = fetch_records(params)
        records = where_handler(records, where_clause)
        records = group_handler(records, group_values)
        records = order_handler(records, order_clause)
        records
      end

      def where_handler(records, where_clause)
        super(records, Relation::WhereClause.new(where_clause.conditions.map(&:to_h).inject({}, :merge!).except(*param_keys)))
      end

      def order_handler(records, order_clause)
        raise NotImplementedError.new, 'ActiveAny::Slack not supported to reverse order' if order_clause.reverse?
        super
      end

      private

      def fetch_records(params)
        response = client.send(api_name, params)
        response['members'].map { |member| klass.new(member.to_h) }
      end

      def client
        @client ||= ::Slack::Web::Client.new(token: ActiveAny::Slack.config.token)
      end
    end
  end
end
