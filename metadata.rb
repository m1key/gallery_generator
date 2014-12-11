class Metadata
  attr_reader :height, :iso, :focal_length, :f_number, :exposure_time
  def initialize(height, iso, focal_length, f_number, exposure_time)
    @height = height
    @iso = iso
    @focal_length = focal_length
    @f_number = f_number
    @exposure_time = exposure_time
  end
end

