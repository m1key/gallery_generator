require 'date'
require 'erb'
require 'yaml'
require 'exifr'
require 'fileutils'
require_relative 'viewable_gallery'
require_relative 'gallery_config'
require_relative 'photo'
require_relative 'metadata'
require_relative 'console_utils'
require_relative 'string_utils'
require_relative 'photos_utils'

OUTPUT_FILE = "index.html"
GALLERY_CONFIG_FILE = "gallery.yaml"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
photos_info = load_photos_info(gallery_config)
gallery = ViewableGallery.new(gallery_config, photos_info)

puts "Writing gallery file #{OUTPUT_FILE}..."
template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(binding)) }

puts "#{OUTPUT_FILE} written."

