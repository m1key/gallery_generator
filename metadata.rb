class Metadata
  attr_reader :height, :iso, :focal_length, :f_number
  def initialize(height, iso, focal_length, f_number)
    @height = height
    @iso = iso
    @focal_length = focal_length
    @f_number = f_number
  end
end

