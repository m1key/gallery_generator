puts "Gallery Generator"
puts "www.m1key.me"
puts "This generates a m1key.me style gallery HTML code."
puts
puts "What is the gallery title?"

gallery_title = gets.chomp.strip
if gallery_title.empty? 
  abort "Gallery title cannot be empty."
end

puts "Gallery title is [#{gallery_title}]"

