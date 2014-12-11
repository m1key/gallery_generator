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
puts

current_year = Date.today.strftime("%Y")
puts "What is the gallery year? [#{current_year}]"
gallery_year_s = gets.chomp.strip
if gallery_year_s.empty?
  gallery_year = Integer(current_year)
else
  unless gallery_year_s.is_i?
    abort "Gallery year needs to be a number."
  end
  gallery_year = Integer(gallery_year_s)
  unless gallery_year > 999 and gallery_year < 10000
    abort "Gallery year should be exactly four digits long."
  end
end
puts "Gallery year is [#{gallery_year}]."
puts 

# TODO read actual values
photos = [Photo.new("01", "Tashkent"), Photo.new("02", "Mosque in Bukhara"), Photo.new("03", "On a train to Samarqand")]

puts "Writing gallery file #{OUTPUT_FILE}..."

template_file = File.open("template.erb", 'r').read
erb = ERB.new(template_file)
File.open("index.html", 'w+') { |file| file.write(erb.result(binding)) }

puts "#{OUTPUT_FILE} written."

