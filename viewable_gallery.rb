require_relative 'string_utils'

class ViewableGallery
  attr_reader :title, :description, :slug, :sources, :upload_date, :map_url, :map_title, :year, :photos
  def initialize(title, description, slug, sources, upload_date, map_url, map_title, year, photos)
    @title = title
    @description = description
    @slug = slug
    @sources = sources
    @upload_date = upload_date
    @map_url = map_url
    @map_title = map_title
    @year = year
    @photos = photos
  end

  def get_binding
    binding()
  end

  def update_using(&update_function)
    updated_gallery = update_function.call(MutableViewableGallery.new(self))
    return ViewableGallery.new(updated_gallery.title, updated_gallery.description, updated_gallery.slug, \
      updated_gallery.sources, updated_gallery.upload_date, updated_gallery.map_url, \
      updated_gallery.map_title, updated_gallery.year, updated_gallery.photos)
  end
end

class MutableViewableGallery
  attr_accessor :title, :description, :slug, :sources, :upload_date, :map_url, :map_title, :year, :photos
  def initialize(viewable_gallery)
    @title = viewable_gallery.title
    @description = viewable_gallery.description
    @slug = viewable_gallery.slug
    @sources = viewable_gallery.sources
    @upload_date = viewable_gallery.upload_date
    @map_url = viewable_gallery.map_url
    @map_title = viewable_gallery.map_title
    @year = viewable_gallery.year
    @photos = viewable_gallery.photos
  end
end
