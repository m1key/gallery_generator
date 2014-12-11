require 'date'
require 'erb'
require 'yaml'
require_relative 'photo'

OUTPUT_FILE = "index.html"
GALLERY_CONFIG_FILE = "gallery.yaml"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

puts "Attempting to parse #{GALLERY_CONFIG_FILE} to read gallery configuration..."
gallery_configuration = YAML.load_file(GALLERY_CONFIG_FILE)
puts "Parsed, seemingly."
puts

gallery_title = gallery_configuration["title"]
puts "Gallery title is [#{gallery_title}]."
map_url = gallery_configuration["map"]["url"]
puts "Gallery map url is [#{map_url}]."
map_title = gallery_configuration["map"]["title"]
puts "Gallery map title is [#{map_title}]."
gallery_slug = gallery_configuration["slug"]
puts ["Gallery slug is [#{gallery_slug}]."]
gallery_description = gallery_configuration["description"]
puts ["Gallery description is [#{gallery_description}]."]

def tabs(how_many_tabs)
  tabs = ""
  how_many_tabs.times do
    tabs += "\t"
  end
  return tabs
end

def add_tabs_before_every_line(multi_line_string, how_many_tabs)
  result = ""
  multi_line_string.each_line do |line|
    result += tabs(how_many_tabs) + line
  end
  return result
end

gallery_description = add_tabs_before_every_line(gallery_description, 2)

gallery_year_from_yaml =  gallery_configuration["year"]
if gallery_year_from_yaml == "current"
  puts "Using current year for gallery year..."
  current_year = Date.today.strftime("%Y")
  gallery_year = Integer(current_year)
else
  gallery_year = Integer(gallery_year_from_yaml)
  unless gallery_year > 999 and gallery_year < 10000
    abort "Gallery year should be exactly four digits long."
  end
end
puts "Gallery year is [#{gallery_year}]."
puts 

def to_photo_id(current_photo_number, photo_id_digits)
  photo_id = "#{current_photo_number}"
  while photo_id.size < photo_id_digits
    photo_id = "0" + photo_id
  end
  return photo_id
end

photos = []
current_photo_number = 0
total_photos_number = gallery_configuration["photos"].size
photo_id_digits = Math::log10(total_photos_number) + 1 
puts "There are [#{total_photos_number}] photos total."
gallery_configuration["photos"].each do |photo|
  current_photo_number += 1
  photo_id = to_photo_id(current_photo_number, photo_id_digits)
  photo_title = photo["title"]
  photo_description = photo["description"]
  puts "Adding photo with ID [#{photo_id}], title [#{photo_title}], description [#{photo_description}]..."
  photos.push Photo.new(photo_id, photo_title, photo_description)
end

puts "Writing gallery file #{OUTPUT_FILE}..."

template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file, nil, '-')
File.open("index.html", 'w+') { |file| file.write(erb.result(binding)) }

puts "#{OUTPUT_FILE} written."

