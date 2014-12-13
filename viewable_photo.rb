class ViewablePhoto
  attr_reader :id, :title, :description, :metadata
  def initialize(id, title, description, metadata)
    @id = id
    @title = title
    @description = description
    @metadata = metadata
  end
end
