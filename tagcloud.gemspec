Gem::Specification.new do |s|
  s.name = 'tagcloud'
  s.version = '0.1.2'
  s.summary = 'tagcloud'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('polyrex')
  s.add_dependency('dynarex') 
  s.signing_key = '../privatekeys/tagcloud.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/tagcloud'
end
