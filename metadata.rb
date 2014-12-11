class Metadata
  attr_reader :height, :iso, :focal_length
  def initialize(height, iso, focal_length)
    @height = height
    @iso = iso
    @focal_length = focal_length
  end
end

