require_relative 'viewable_gallery'
require_relative 'viewable_photo'
require_relative 'gallery_config'
require_relative 'console_utils'
require_relative 'string_utils'
require_relative 'photos_utils'
require_relative 'gallery_mutators'

def add_tabs_before_every_description_line(how_many_tabs)
  return lambda do |mutable_viewable_content|
    mutable_viewable_content.description = add_tabs_before_every_line(mutable_viewable_content.description, how_many_tabs)
    return mutable_viewable_content
  end
end

@add_links_to_descriptions = lambda do |mutable_viewable_content|
  mutable_viewable_content.description = add_links_to_sources(mutable_viewable_content.description)
  return mutable_viewable_content
end

@remove_final_empty_line_from_description = lambda do |mutable_viewable_content|
  mutable_viewable_content.description = remove_final_empty_line(mutable_viewable_content.description)
  return mutable_viewable_content
end

def for_each_photo(&update_function)
  return lambda do |mutable_viewable_gallery|
    mutable_viewable_gallery.photos.each do |mutable_viewable_photo|
      update_function.call(mutable_viewable_photo)
    end
    return mutable_viewable_gallery
  end
end

