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
puts "What is the gallery year?"
gallery_year_s = gets.chomp.strip
unless gallery_year_s.is_i?
  abort "Gallery year needs to be a number."
end
gallery_year = Integer(gallery_year_s)

puts "Gallery year is [#{gallery_year}]."

