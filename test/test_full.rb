require 'minitest/autorun'
require 'gallery_generator'

class FullTest < Minitest::Test

  def test_full
    bin_script = File.join(File.dirname(__FILE__), "..", "bin", "gallery_generator")
    working_directory = File.join(File.dirname(__FILE__), "..", "test", "data")
    `ruby -Ilib #{bin_script} #{working_directory}`
    output_file = File.join(working_directory, "index.html")
    expected_output_file = File.join(working_directory, "expected_output.html")
    assert FileUtils.compare_file(output_file, expected_output_file), "Generated index.html does not match expected_output.html."
  end
end
