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

OUTPUT_FILE = "index.html"
GALLERY_CONFIG_FILE = "gallery.yaml"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

gallery_config = GalleryConfig.new(GALLERY_CONFIG_FILE)
gallery = ViewableGallery.new(gallery_config)

def to_photo_id(current_photo_number, photo_id_digits)
  photo_id = "#{current_photo_number}"
  while photo_id.size < photo_id_digits
    photo_id = "0" + photo_id
  end
  return photo_id
end

def get_metadata_for_image_with_file_name_containing(photo_file_name_contains)
  selected_file_name = ""
  Dir.entries(".").each do |file_name|
    if file_name.include? photo_file_name_contains.to_s
      unless selected_file_name == ""
        puts "WARN  More than one file name matches [#{photo_file_name_contains}]. Will use the last one that matches."
      end
      selected_file_name = file_name
    end
  end
  if selected_file_name == ""
    puts "WARN  No matching photo found for #{photo_file_name_contains}."
    return
  end
 
  exif = EXIFR::JPEG.new(selected_file_name)
  photo_height = exif.height
  photo_iso = exif.iso_speed_ratings
  photo_focal_length = exif.focal_length.to_f.round.to_s
  photo_f_number = exif.f_number.to_f
  photo_exposure_time = exif.exposure_time.to_s
  return Metadata.new(selected_file_name, photo_height, photo_iso, photo_focal_length, photo_f_number, photo_exposure_time)
end

def create_gallery_image(original_file_name, gallery_slug, photo_id)
  FileUtils.cp(original_file_name, gallery_slug + "_" + photo_id + File.extname(original_file_name))
end

def add_links_to_sources(multi_line_string)
  result = ""
  multi_line_string.each_line do |line|
    line_with_empty_line_removed =  line.gsub(/\[(\d)\]/, '[<a href="#sources">\1</a>]')
    result += line_with_empty_line_removed
  end
  return result
end

photos = []
current_photo_number = 0
total_photos_number = gallery_config.total_photos_number
photo_id_digits = gallery_config.photo_id_digits 
puts "There are [#{total_photos_number}] photos total."
gallery_config.photos.each do |photo|
  current_photo_number += 1
  photo_id = to_photo_id(current_photo_number, photo_id_digits)
  photo_title = photo["title"]
  photo_description = add_links_to_sources(remove_final_empty_line(add_tabs_before_every_line(photo["description"], 3)))
  photo_file_name_contains = photo["fileNameContains"]
  photo_metadata = get_metadata_for_image_with_file_name_containing(photo_file_name_contains)
  
  puts "Adding photo with ID [#{photo_id}], title [#{photo_title}], height [#{photo_metadata.height}], description [#{compact(photo["description"])}]..."
  photos.push Photo.new(photo_id, photo_title, photo_description, photo_metadata)
  
  create_gallery_image(photo_metadata.original_file_name, gallery.slug, photo_id)
end

puts "Writing gallery file #{OUTPUT_FILE}..."

template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(binding)) }

puts "#{OUTPUT_FILE} written."

