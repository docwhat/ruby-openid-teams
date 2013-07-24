require 'spec_helper'
require 'openid/extensions/teams'
require 'openid/message'
require 'openid/server'

describe OpenID::Teams do
  it 'should have a version number' do
    OpenID::Teams::VERSION.should_not be_nil
  end

  describe "Message" do
    context "for openid 1" do
      it "accepts lp.query_membership" do
        args = {
          'lp.query_membership'=> 'usa,germany,france',
        }

        m = OpenID::Message.from_openid_args(args)
        query_membership = m.get_arg(OpenID::Teams::NS_URI, 'query_membership')
        expect(query_membership).to eq('usa,germany,france')
      end
    end
  end
end

describe OpenID::Teams::Request do
  describe "#from_openid_request" do
    context "a typical openid 1 request" do
      let(:teams) { ['admin', 'peon'] }
      it "parses the request correctly" do
        message = OpenID::Message.from_openid_args(
          'ns.lp' => OpenID::Teams::NS_URI,
          'lp.query_membership' => teams.join(',')
        )
        openid_req = OpenID::Server::OpenIDRequest.new
        openid_req.message = message
        teams_req = OpenID::Teams::Request.from_openid_request(openid_req)

        expect(teams_req.teams).to match_array(teams)
      end
    end

    context "a non-teams request" do
      it "returns nil" do
        message = OpenID::Message.new

        openid_req = OpenID::Server::OpenIDRequest.new
        openid_req.message = message
        teams_req = OpenID::Teams::Request.from_openid_request(openid_req)

        expect(teams_req).to be_nil
      end

    end
  end

  describe ".get_extension_args" do
    context "with teams" do
      let(:teams) { ['admin', 'peon', 'minister'] }
      it "returns query_membership: a comma separated list" do
        req = OpenID::Teams::Request.new(teams)
        expect(req.get_extension_args).to include('query_membership' => teams.join(','))
      end
    end
  end
end

describe OpenID::Teams::Response do
  describe "#extract_response" do
    context "requesting teams" do
      let(:requested_teams) { ['peon', 'minister'] }
      let(:request) { double(OpenID::Teams::Request, :teams => requested_teams) }

      it "uses the subset" do
        response = OpenID::Teams::Response.extract_response(request, ['admin', 'peon'])
        expect(response.teams).to match_array(['peon'])
      end
    end
  end

  describe ".get_extension_args" do
    context "with teams" do
      let(:teams) { ['admin', 'peon', 'minister'] }
      it "returns is_member: a comma separated list" do
        req = OpenID::Teams::Response.new(teams)
        expect(req.get_extension_args).to include('is_member' => teams.join(','))
      end
    end
  end
end
