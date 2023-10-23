# vod-chat-combiner

**vod-chat-combiner** is a Bash script designed to automate the processing of chat replays into Twitch VODs using [TwitchDownloaderCLI](https://github.com/lay295/TwitchDownloader) and [FFmpeg](https://ffmpeg.org/).

## Prerequisites

To use vod-chat-combiner, make sure you have the following prerequisites in place:

- A Bash-supported environment, such as Unix-like systems (e.g., Linux), or Windows Subsystem for Linux (WSL) if you are on Windows.
- [TwitchDownloaderCLI](https://github.com/lay295/TwitchDownloader), either available in your `$PATH` or provided through the `--twitch-dl-path` option.
- A sufficiently powerful PC to process video; a better CPU will result in faster processing times.

## Usage

You can use vod-chat-combiner with the following command:

```bash
./vod-chat-combiner [OPTIONS] VOD_ID
```

Where `VOD_ID` represents the numerical identifier found in a Twitch VOD link (e.g., for the link https://twitch.tv/videos/1954084757, the `VOD_ID` is 1954084757).

If the `--ffmpeg-path` option is not provided, and `ffmpeg` or `ffprobe` is not found in the `bin` directory, it will be automatically downloaded by TwitchDownloaderCLI.

## Options

- `-m|--mode` - Specifies the processing mode, which can be found in a Bash script in the `modes` directory. The default mode is `masked`.
- `-b|--beginning` - Indicates the starting point for cropping the VOD, supporting input in seconds or timestamp format (HH:MM:SS).
- `-e|--ending` - Specifies the ending point for cropping the VOD, supporting input in seconds or timestamp format (HH:MM:SS).
- `-q|--quality` - The video quality the VOD will be downloaded in, e.g., `1080p60` or `480p`. If not found or not provided, the VOD will be downloaded in the highest quality by default.
- `-o|--output` - Defines the output file for the processed video, including the file extension.
- `--twitch-dl-path` - Overrides the `$PATH` location to provide TwitchDownloaderCLI from a specific directory.
- `--ffmpeg-path` - Allows you to specify the FFmpeg binary to use, instead of the one downloaded by TwitchDownloaderCLI.
- `-f|--font` - Specifies the font to use for chat rendering. The default font is provided by TwitchDownloaderCLI.
- `-w|--chat-width` - Width of the chat replay. The default width depends on the processing mode.
- `--font-size` - Specifies the font size to use for chat rendering. The default font size is provided by TwitchDownloaderCLI.
- `--emoji-vendor` - Sets the emoji vendor to use in chat rendering. The default vendor is provided by TwitchDownloaderCLI.

## Modes

Modes refer to different methods for processing chat replays into your VOD. You can explore and read the comments in the default modes available in the [modes](/modes) directory.

## License

This script is distributed under the terms of the [MIT license](/LICENSE).
