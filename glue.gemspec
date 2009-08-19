# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{glue}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jordan Dobson"]
  s.date = %q{2009-08-18}
  s.default_executable = %q{glue}
  s.description = %q{The Glue gem enables posting to GlueNow.com API service using an account subdomain, username, password. In this version you can add a post by providing a title, body, optional author name and optional private settings. You can also access some basic info about a users account and check if their account info is valid.

You can also request public posts from an account using the same RSS that powers the many Glue feeds.}
  s.email = ["jordan.dobson@madebysquad.com"]
  s.executables = ["glue"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/glue", "lib/glue.rb", "test/test_glue.rb"]
  s.homepage = %q{http://Glue.RubyForge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{glue}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{The Glue gem enables posting to GlueNow.com API service and reading posts}
  s.test_files = ["test/test_glue.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.12.2"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.12.2"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.12.2"])
  end
end