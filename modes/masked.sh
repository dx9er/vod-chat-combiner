#!/usr/bin/env bash

VOD_HEIGHT="$("$(get_ffmpeg_path)/ffprobe" -v quiet -of default=nk=1:nw=1 -select_streams v:0 -show_entries stream=height "${VOD_ID}/vod.mp4")"
$(twitch_dl "chatrender") -i "${VOD_ID}/chat.json" -o "${VOD_ID}/chat.mp4" \
    -w $([[ -n $CHAT_WIDTH ]] && echo -n "${CHAT_WIDTH}" || echo -n "340") -h "$VOD_HEIGHT" \
    $([[ -n $EMOJI_VENDOR ]] && echo -n "--emoji-vendor "${EMOJI_VENDOR}"") \
    --update-rate 0 --dispersion true \
    $([[ -n $CHAT_FONT ]] && echo -n "--font "${CHAT_FONT}"") \
    $([[ -n $CHAT_FONT_SIZE ]] && echo -n "--font-size ${CHAT_FONT_SIZE}") \
    --outline true --generate-mask --background-color '#00000000' \
    --ffmpeg-path "$(get_ffmpeg_path)/ffmpeg" && \
# Render with masked chat
# https://github.com/lay295/TwitchDownloader/issues/79#issuecomment-699648513
"$(get_ffmpeg_path)/ffmpeg" -y  -i "${VOD_ID}/vod.mp4" -i "${VOD_ID}/chat.mp4" -i "${VOD_ID}/chat_mask.mp4" \
    -c:a copy -preset veryfast \
    -filter_complex '[1][2]alphamerge[ia];[0][ia]overlay=main_w-overlay_w:main_h-overlay_h' \
    "$([[ -n $OUTPUT ]] && echo -n "$OUTPUT" || echo -n "${VOD_ID}.mp4")"
