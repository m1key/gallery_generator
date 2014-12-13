require_relative 'string_utils'

class ViewableGallery
  attr_reader :title, :description, :slug, :sources, :upload_date, :map_url, :map_title, :year, :photos
  def initialize(gallery_config, photos)
    @title = gallery_config.title
    @description = add_tabs_before_every_line(gallery_config.description, 2)
    @slug = gallery_config.slug
    @sources = gallery_config.sources
    @upload_date = gallery_config.upload_date
    @map_url = gallery_config.map_url
    @map_title = gallery_config.map_title
    @year = gallery_config.year
    @photos = photos
  end
end
