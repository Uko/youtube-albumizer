#!/usr/bin/env ruby

require 'mkmf'
require 'csv'
require 'fileutils'
require 'taglib'
require 'open-uri'
require 'json'
require_relative 'duration'


%w(youtube-dl ffmpeg).each do | command |
  abort("You need #{command} for this to work") if find_executable(command).nil?
end


download_command = 'youtube-dl %s -f best -o "full.%%(ext)s" https://youtu.be/85ZL2T-J0MQ'
file_name = `#{download_command % '--get-filename'}`.strip

puts 'Downloading the movie… (may take a while)'
`#{download_command % '-q'}`


puts "\nProcessing:"
album_data = JSON.parse(File.read('album_data.json'))
cover_image = open(album_data['cover']).read

last_cut = Duration.new
FileUtils.mkdir_p 'Album'

songs = CSV.read('song_timing.csv')

songs.each_with_index do | data, index |
  song_name = data[0].strip
  next_cut = Duration.from_string(data[1].strip)

  puts song_name
  song_file_name = "album/#{(index + 1).to_s.rjust(2, '0')} #{song_name}.m4a"
  `ffmpeg -loglevel panic -y -ss #{last_cut} -i #{file_name} -t #{next_cut - last_cut} -vn -c:a copy '#{song_file_name}'`
  last_cut = next_cut

  TagLib::MP4::File.open(song_file_name) do |file|

    item_list_map = file.tag.item_list_map
    item_list_map.insert('©nam', TagLib::MP4::Item.from_string_list([song_name]))
    item_list_map.insert('©alb', TagLib::MP4::Item.from_string_list([album_data['title']]))
    item_list_map.insert('©ART', TagLib::MP4::Item.from_string_list([album_data['artist']]))
    item_list_map.insert('aART', TagLib::MP4::Item.from_string_list([album_data['artist']]))
    item_list_map.insert('©gen', TagLib::MP4::Item.from_string_list([album_data['genre']]))
    item_list_map.insert('©day', TagLib::MP4::Item.from_string_list([album_data['date']]))
    item_list_map.insert('trkn', TagLib::MP4::Item.from_int_pair([index + 1, songs.length]))
    item_list_map.insert('disk', TagLib::MP4::Item.from_int_pair([1, 1]))

    cover_art = TagLib::MP4::CoverArt.new(TagLib::MP4::CoverArt::JPEG, cover_image)
    item = TagLib::MP4::Item.from_cover_art_list([cover_art])
    item_list_map.insert('covr', item)

    file.save

  end

end