Gallery Generator
=================

## Info

This Ruby script generates www.m1key.me style gallery.

A sample gallery is this: http://www.m1key.me/photography/mauritania_part_2/

## Status

This is work in progress.

## Example usage

ruby generate_gallery.rb

This assumes there is a valid gallery.yaml file present in the current folder,
and the photos themselves in the format DSC_1234.jpg.

Before running, install the necessary gems:
> gem install exifr
> gem install minitest
> gem install rspec

## Tests

To run the rspec test:
> rspec viewable_gallery_spec.rb

