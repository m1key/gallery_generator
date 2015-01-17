Gallery Generator
=================

## Info

This Ruby script generates www.m1key.me style gallery.

A sample gallery is this: http://www.m1key.me/photography/mauritania_part_2/

## Status

This is work in progress, but has been used to generate real-life galleries.

## Example usage

>ruby -Ilib bin/gallery_generator test/data 

This assumes there is a valid gallery.yaml file present in the current folder,
and the photos themselves in the format DSC_1234.jpg.

Before running, install the necessary gems:
> gem install exifr

> gem install minitest

> gem install rspec


You must update the gems afterwards:
> gem update

## Tests

To run the Minitest tests:
> rake

To run the rspec tests:
> rspec spec 

## Gem

To build gem:
> gem build gallery_generator.gemspec

To install gem:
> gem install gallery_generator-0.0.5.gem

To test gem:
> irb

> require 'gallery_generator'

