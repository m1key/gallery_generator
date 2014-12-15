require 'erb'
require_relative 'viewable_gallery'
require_relative 'viewable_photo'
require_relative 'gallery_config'
require_relative 'console_utils'
require_relative 'string_utils'
require_relative 'photos_utils'
require_relative 'gallery_mutators'

OUTPUT_FILE = "index.html"
GALLERY_CONFIG_FILE = "gallery.yaml"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
viewable_photos = photos_config_into_viewable_photos(gallery_config)

gallery = ViewableGallery.new(gallery_config.title, gallery_config.description, gallery_config.slug, \
  gallery_config.sources, gallery_config.upload_date, gallery_config.map_url, gallery_config.map_title, \
  gallery_config.year, viewable_photos).
  update_using( \
    add_tabs_before_every_description_line(2), \
    @add_links_to_descriptions, \
    for_each_photo(&add_tabs_before_every_description_line(3)), \
    for_each_photo(&@add_links_to_descriptions), \
    for_each_photo(&@remove_final_empty_line_from_description))

puts "Writing gallery file #{OUTPUT_FILE}..."
template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(gallery.get_binding)) }

puts "#{OUTPUT_FILE} written."

