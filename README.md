# vod-chat-combiner
vod-chat-combiner is a Bash script which automatically processes chat replay into Twitch VODs through [TwitchDownloaderCLI](https://github.com/lay295/TwitchDownloader) and [FFmpeg](https://ffmpeg.org/).
## Prerequisites
- A Bash supported environment such as Unix-like systems e.g. Linux (WSL if on Windows)
- [TwitchDownloaderCLI](https://github.com/lay295/TwitchDownloader) provided through `$PATH` or the `--twitch-dl-path` option
- A strong enough PC for processing video, better CPU means faster processing times
## Usage
```
./vod-chat-combiner [OPTIONS] VOD_ID
```
where `VOD_ID` is the numbers (or "ID") in a Twitch VOD link (e.g. https://twitch.tv/videos/1954084757 is 1954084757)

If `--ffmpeg-path` option is not provided and `ffmpeg` or `ffprobe` are not found in the `bin` directory, it will be automatically downloaded by TwitchDownloaderCLI.
## Options
- `-m|--mode` - Processing mode found in a Bash script in `modes` directory. Default is `masked`
- `-b|--beginning` - The beginning of where you want to crop the VOD. Supports seconds and timestamp format (HH:MM:SS)
- `-e|--ending` - The ending of where you want to crop the VOD. Supports seconds and timestamp format (HH:MM:SS)
- `-o|--output` - File to output processed video to. Must include extension
- `--twitch-dl-path` - Override `$PATH` location to provide TwitchDownloaderCLI from
- `--ffmpeg-path` - Override which FFmpeg binary to use instead of the one downloaded by TwitchDownloaderCLI
- `-f|--font` - Which font to use in chat render. Default is provided by TwitchDownloaderCLI
- `--emoji-vendor` - Which emoji vendor to use in chat render. Default is provided by TwitchDownloaderCLI
## Modes
Modes are different ways to process the chat replay into your VOD. You may check and read the comments of the defaults from the [modes](/modes) directory.
## License
This script is licensed under the [MIT license](/LICENSE).
