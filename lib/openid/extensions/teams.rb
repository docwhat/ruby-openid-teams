# Implements LaunchPad's OpenIDTeams specification
# https://dev.launchpad.net/OpenIDTeams

jequire 'openid/extensions/teams/version'
require 'openid/extension'
require 'set'
require 'openid/message'

module OpenID
  module Teams
    NS_URI = 'http://ns.launchpad.net/2007/openid-teams'

    begin
      Message.register_namespace_alias(NS_URI, 'teams')
    rescue NamespaceAliasRegistrationError => e
      Util.log(e)
    end

    class Request < Extension
      attr_accessor :ns_alias, :ns_uri, :teams

      def initialize teams
        @ns_alias = 'teams'
        @ns_uri = NS_URI
        @teams = Array(teams)
      end

      def self.from_openid_request(request)
        args = request.message.get_args(NS_URI)
        return nil if {} == args
        teams = args['query_membership'].split(',')
        new(teams)
      end

      # Get the string arguments that should be added to an OpenID
      # message for this extension.
      def get_extension_args
        args = {}
        args['query_membership'] = @teams.join(',') unless @teams.empty?
        return args
      end
    end

    class Response < Extension
      attr_accessor :ns_alias, :ns_uri

      def initialize teams
        @ns_alias = 'teams'
        @ns_uri = NS_URI
        @teams = Array(teams)
      end

      def self.extract_response(request, teams)
        requested_teams = Set.new request.teams
        available_teams = Set.new teams
        new(requested_teams.intersection(available_teams).to_a)
      end

      # Get the string arguments that should be added to an OpenID
      # message for this extension.
      def get_extension_args
        args = {}
        args['is_member'] = @teams.join(',') unless @teams.empty?
        return args
      end
    end

  end
end
