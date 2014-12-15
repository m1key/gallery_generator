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

add_tabs_before_every_description_line = lambda do |mutable_viewable_gallery|
  mutable_viewable_gallery.description = add_tabs_before_every_line(mutable_viewable_gallery.description, 2)
  return mutable_viewable_gallery
end

add_tabs_before_every_photo_description_line = lambda do |mutable_viewable_gallery|
  mutable_viewable_gallery.photos.each do |mutable_viewable_photo|
    mutable_viewable_photo.description = add_tabs_before_every_line(mutable_viewable_photo.description, 3)
  end
  return mutable_viewable_gallery
end

add_links_to_photo_descriptions = lambda do |mutable_viewable_gallery|
  mutable_viewable_gallery.photos.each do |mutable_viewable_photo|
    mutable_viewable_photo.description = add_links_to_sources(mutable_viewable_photo.description)
  end
  return mutable_viewable_gallery
end

remove_final_empty_line_from_photo_descriptions = lambda do |mutable_viewable_gallery|
  mutable_viewable_gallery.photos.each do |mutable_viewable_photo|
    mutable_viewable_photo.description = remove_final_empty_line(mutable_viewable_photo.description)
  end
  return mutable_viewable_gallery

end

def add_links_to_sources(multi_line_string)
  result = ""
  multi_line_string.each_line do |line|
    line_with_source_link_added =  line.gsub(/\[(\d)\]/, '[<a href="#sources">\1</a>]')
    result += line_with_source_link_added
  end
  return result
end

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
viewable_photos = photos_config_into_viewable_photos(gallery_config)
gallery = ViewableGallery.new(gallery_config.title, gallery_config.description, gallery_config.slug, \
  gallery_config.sources, gallery_config.upload_date, gallery_config.map_url, gallery_config.map_title, \
  gallery_config.year, viewable_photos).
  update_using( \
    add_tabs_before_every_description_line, \
    add_tabs_before_every_photo_description_line, \
    add_links_to_photo_descriptions, \
    remove_final_empty_line_from_photo_descriptions)

puts "Writing gallery file #{OUTPUT_FILE}..."
template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(gallery.get_binding)) }

puts "#{OUTPUT_FILE} written."

