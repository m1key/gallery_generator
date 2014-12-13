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

add_tabs_before_every_description_line = lambda do |mutable_viewable_gallery|
  mutable_viewable_gallery.description = add_tabs_before_every_line(mutable_viewable_gallery.description, 2)
  return mutable_viewable_gallery
end

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
photos_info = load_photos_info(gallery_config)
gallery = ViewableGallery.new(gallery_config.title, gallery_config.description, gallery_config.slug, \
  gallery_config.sources, gallery_config.upload_date, gallery_config.map_url, gallery_config.map_title, \
  gallery_config.year, photos_info).update_using(&add_tabs_before_every_description_line)

puts "Writing gallery file #{OUTPUT_FILE}..."
template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(gallery.get_binding)) }

puts "#{OUTPUT_FILE} written."

