#!/usr/bin/env ruby

# file: tagcloud.rb

require 'dynarex'
require 'polyrex'

class TagCloud

  def initialize(opt)
    opts = {uri: '', tags: [], public_path: '/tags'}.merge(opt)
    uri, tags, public_path = [:uri, :tags, :public_path].map{|x| opts[x]}

    main(uri, tags, 'tags.xml')
    index(public_path, tags, 'index.xml')

    # add it to rows --> [tag]_rows.xml
    rows(tags, uri)

    # add it to [tag] -> [tag].xml
    tag(public_path, tags)
  end

  def main(uri, tags=[], filename='tags.xml')

    polyrex = Polyrex.new('entries/entry[tag]/urls[url]')

    tags.each do |tag|
      polyrex.create.entry(tag: tag) {|create|  create.urls(url: uri) }
    end

    polyrex.save filename, pretty: true
  end

  def index(public_path, tags=[], filename='index.xml')

    if File.exists? filename then
      dynarex = Dynarex.new(filename)
    else
      dynarex = Dynarex.new('tags/entry(tag,url)')  
    end

    tags.each do |tag|
      dynarex.create tag: tag, url: "%s/%s.html" % [public_path, tag]
    end

    dynarex.save filename, pretty: true
  end


  def rows(tags=[], url)

    tags.each do |tag| 

      filename = "%s_rows.xml" % tag

      if File.exists? filename then

        dynarex = Dynarex.new()

      else

        dynarex = Dynarex.new('entries/entry(url)')

      end


      dynarex.create url: url

      dynarex.save filename, pretty: true
    end

  end



  def tag(public_path, tags=[])

    tags.length.times do |tag|

      tags.rotate!
      main_tag = tags.first
      filename = "%s.xml" % main_tag

      if File.exists? filename then

        dynarex = Dynarex.new(filename)

      else

        dynarex = Dynarex.new('entries[tag]/entry(tag, url)')  
      end

      dynarex.summary['tag'] = main_tag
      tags[1..-1].each do |tag|
        dynarex.create tag: tag, url: "%s/%s.html" % [public_path, tag]
      end

      dynarex.save filename, pretty: true
    end

  end

end
