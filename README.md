This project makes use of [`youtube-dl`](https://rg3.github.io/youtube-dl/) and [`ffmpeg`](https://ffmpeg.org). Also gems depend on [`taglib`](https://taglib.github.io/) and maybe something more.

Don't forget to run

    bundler install
    
to install required gem(s).

To create the album run

    ./main.rb
    

#####Tweakable data
`album_data.json` contains album metadata such as album name, author, etc… Cover-art file can be also referenced locally. Also it contains a url to video.

`song_timing.csv` contains song names and their ending time in the format `HH.MM.SS.mmm`. Songs beginnning with `--` will be ignored, so you can use this to skip comercials in the video of the concert.

**.20** files contain a configuration from the _"OE 20years together"_ concert.