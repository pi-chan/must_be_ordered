
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "must_be_ordered/version"

Gem::Specification.new do |spec|
  spec.name          = "must_be_ordered"
  spec.version       = MustBeOrdered::VERSION
  spec.authors       = ["pi-chan", "nof"]
  spec.email         = ["hiromasa.ohno.1007@gmail.com"]

  spec.summary       = "`must_be_ordered` gem is to warn or raise error if `order` is not set to ActiveRecord's Relation."
  spec.description   = ""
  spec.homepage      = "https://github.com/pi-chan/must_be_ordered"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activerecord', ['>= 5.0']

  spec.add_development_dependency 'bundler', "~> 1.16"
  spec.add_development_dependency 'rake', "~> 10.0"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'pry-byebug'
end
