# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'chimpbook'
  spec.version       = '0.0.1'
  spec.authors       = ['Sam Dunne']
  spec.email         = ['sam@sam-dunne.com']
  spec.summary       = 'Cookbook generator for Monkey Little'
  spec.description   = spec.summary
  spec.homepage      = ''
  spec.license       = 'apache2'

  spec.files         = Dir.glob('**/*', File::FNM_DOTMATCH).keep_if { |file| File.file?(file) } - %w(. .. .DS_Store) - Dir.glob('{.git}/**/*')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'chef-gen-flavors', '~> 0.8'
end
