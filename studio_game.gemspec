Gem::Specification.new do |s|
  s.name         = "missy-studio-game"
  s.version      = "1.0.0"
  s.author       = "Missy Davies following the Pragmatic Studio Ruby course tutorial"
  s.email        = "ms.melissadavies@gmail.com"
  s.homepage     = "https://github.com/missy-davies/studio-game-gem"
  s.summary      = "Gem that plays a game with multiple rounds and players."
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec', '~> 2.8', '>= 2.8.0'
end
