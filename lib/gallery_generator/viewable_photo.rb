module GalleryGenerator
  class ViewablePhoto
    attr_reader :id, :title, :description, :metadata
    def initialize(id, title, description, metadata)
      @id = id
      @title = title
      @description = description
      @metadata = metadata
    end
  end

  class MutableViewablePhoto
    attr_accessor :id, :title, :description, :metadata
    def initialize(viewable_photo)
      @id = viewable_photo.id
      @title = viewable_photo.title
      @description = viewable_photo.description
      @metadata = viewable_photo.metadata
    end
  end
end

