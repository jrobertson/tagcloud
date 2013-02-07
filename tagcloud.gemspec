Gem::Specification.new do |s|
  s.name = 'tagcloud'
  s.version = '0.1.1'
  s.summary = 'tagcloud'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('polyrex')
  s.add_dependency('dynarex') 
  s.signing_key = '../privatekeys/tagcloud.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
