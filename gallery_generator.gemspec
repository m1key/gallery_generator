Gem::Specification.new do |s|
  s.name        = 'gallery_generator'
  s.version     = '0.0.7'
  s.date        = '2015-03-02'
  s.summary     = "m1key.me-style gallery generator."
  s.description = "This gem allows you to generate a m1key.me-style gallery based on the JPG files in the working directory."
  s.authors     = ["Mike Huniewicz"]
  s.email       = 'michal.huniewicz.registered@gmail.com'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md) 
  s.homepage    =
    'https://github.com/m1key/gallery_generator'
  s.license       = 'MIT'
end
