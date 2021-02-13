# OpenID::Teams

[![Build Status](https://travis-ci.org/docwhat/ruby-openid-teams.svg)](https://travis-ci.org/docwhat/ruby-openid-teams)
[![Coverage Status](https://coveralls.io/repos/docwhat/ruby-openid-teams/badge.png)](https://coveralls.io/r/docwhat/ruby-openid-teams)

> This is an extension for [`ruby-openid`](https://rubygems.org/gems/ruby-openid) to add
[OpenIDTeams](https://dev.launchpad.net/OpenIDTeams) support.
>
> This should work for both a consumer and provider.

## Installation

Add this line to your application's Gemfile:

    gem 'ruby-openid-teams'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-openid-teams

## Usage

This works similar to other extensions, such as SREG and AX.

Example code for a provider:

```ruby
teams_req = OpenID::Teams::Request.from_openid_request(oidreq)
return if teams_req.nil?

teams_data = ['team-a', 'team-b', 'team-c'] # Use your code to provide these strings.

teams_resp = OpenID::Teams::Response.extract_response(teams_req, teams_data)
oidresp.add_extension(teams_resp)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
