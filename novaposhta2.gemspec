Gem::Specification.new do |s|
  s.name        = 'novaposhta2'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Oleg Kukareka']
  s.email       = 'oleg@kukareka.com'
  s.homepage    = 'https://github.com/kukareka/novaposhta2'
  s.summary     = 'Novaposhta API 2.0'
  s.description = ''

  # s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'novaposhta2'

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that are not .rb files, add them here
  s.files        = Dir['{lib}/**/*.rb', '*.md']
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ['newgem']

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end