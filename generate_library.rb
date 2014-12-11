require 'date'
require 'erb'
require_relative 'photo'

OUTPUT_FILE = "index.html"

puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts

puts "What is the gallery title?"
gallery_title = gets.chomp.strip
if gallery_title.empty? 
  abort "Gallery title cannot be empty."
end

class String
  def is_i?
    Integer(self) != nil rescue false
  end
end
puts "Gallery title is [#{gallery_title}]."
puts

current_directory = File.basename(Dir.getwd)
default_slug = current_directory.downcase.tr(" ", "_")
puts "What is the gallery slug? [#{default_slug}]"
gallery_slug = gets.chomp.strip
if gallery_slug.empty?
  gallery_slug = default_slug
end
puts "Gallery slug is [#{gallery_slug}]."
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

