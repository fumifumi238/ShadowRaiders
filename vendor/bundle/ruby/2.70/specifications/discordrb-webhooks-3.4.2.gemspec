# -*- encoding: utf-8 -*-
# stub: discordrb-webhooks 3.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "discordrb-webhooks".freeze
  s.version = "3.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["meew0".freeze, "swarley".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-02-05"
  s.description = "A client for Discord's webhooks to fit alongside [discordrb](https://rubygems.org/gems/discordrb).".freeze
  s.email = ["".freeze]
  s.homepage = "https://github.com/shardlab/discordrb".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Webhook client for discordrb".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>.freeze, [">= 2.0.0"])
    else
      s.add_dependency(%q<rest-client>.freeze, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<rest-client>.freeze, [">= 2.0.0"])
  end
end
