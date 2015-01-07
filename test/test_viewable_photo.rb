require 'minitest/autorun'
require 'viewable_photo.rb'

class ViewablePhotoTest < Minitest::Test

  def test_mutable_viewable_photo_has_properties_from_given_viewable_photo
    photo_id = "10"
    photo_title = "Sample photo"
    photo_description = "Photo description"
    photo_metadata = nil

    viewable_photo = ViewablePhoto.new(photo_id, photo_title, photo_description, photo_metadata)
    mutable_viewable_photo = MutableViewablePhoto.new(viewable_photo)
    
    assert_equal photo_id, mutable_viewable_photo.id, 'photo_id was not copied from viewable to mutable viewable photo'
  end

end

