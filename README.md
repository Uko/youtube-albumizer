This project makes use of [`youtube-dl`](https://rg3.github.io/youtube-dl/) and [`ffmpeg`](https://ffmpeg.org). Also gems depend on [`taglib`](https://taglib.github.io/) and maybe something more.

Don't forget to run

    bundler install
    
to install required gem(s).

To create the album run

    ./main.rb
    

#####Tweakable data
`album_data.json` contains album metadata such as album name, author, etc… Cover-art file can be also referenced locally.

`song_timing.csv` contains song names and their ending time in the format `HH.MM.SS.mmm`.

For now video url is hardcoded. If you want to use this for other videos - let me know it can be fun to make something more generic.
