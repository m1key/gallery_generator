require 'erb'
require_relative 'viewable_gallery'
require_relative 'viewable_photo'
require_relative 'gallery_config'
require_relative 'console_utils'
require_relative 'string_utils'
require_relative 'photos_utils'

OUTPUT_FILE = "index.html"
GALLERY_CONFIG_FILE = "gallery.yaml"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

def add_tabs_before_every_description_line(how_many_tabs)
  return lambda do |mutable_viewable_content|
    mutable_viewable_content.description = add_tabs_before_every_line(mutable_viewable_content.description, how_many_tabs)
    return mutable_viewable_content
  end
end

add_links_to_descriptions = lambda do |mutable_viewable_content|
  mutable_viewable_content.description = add_links_to_sources(mutable_viewable_content.description)
  return mutable_viewable_content
end

remove_final_empty_line = lambda do |mutable_viewable_content|
  mutable_viewable_content.description = remove_final_empty_line(mutable_viewable_content.description)
  return mutable_viewable_content
end

def for_each_photo(&update_function)
  return lambda do |mutable_viewable_gallery|
    mutable_viewable_gallery.photos.each do |mutable_viewable_photo|
      update_function.call(mutable_viewable_photo)
    end
    return mutable_viewable_gallery
  end
end

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
viewable_photos = photos_config_into_viewable_photos(gallery_config)
gallery = ViewableGallery.new(gallery_config.title, gallery_config.description, gallery_config.slug, \
  gallery_config.sources, gallery_config.upload_date, gallery_config.map_url, gallery_config.map_title, \
  gallery_config.year, viewable_photos).
  update_using( \
    add_tabs_before_every_description_line(2), \
    add_links_to_descriptions, \
    for_each_photo(&add_tabs_before_every_description_line(3)), \
    for_each_photo(&add_links_to_descriptions), \
    for_each_photo(&remove_final_empty_line))

puts "Writing gallery file #{OUTPUT_FILE}..."
template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(gallery.get_binding)) }

puts "#{OUTPUT_FILE} written."

