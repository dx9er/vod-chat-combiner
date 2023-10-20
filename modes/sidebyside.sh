#!/usr/bin/env bash

VOD_HEIGHT="$("$(get_ffmpeg_path)/ffprobe" -v quiet -of default=nk=1:nw=1 -select_streams v:0 -show_entries stream=height "${VOD_ID}/vod.mp4")"
$(twitch_dl "chatrender") -i "${VOD_ID}/chat.json" -o "${VOD_ID}/chat.mp4" \
    -w 340 -h "${VOD_HEIGHT}" \
    --update-rate 0 --dispersion true \
    $([[ -n $EMOJI_VENDOR ]] && echo -n "--emoji-vendor "${EMOJI_VENDOR}"") \
    $([[ -n $CHAT_FONT ]] && echo -n "--font "${CHAT_FONT}"") \
    --ffmpeg-path "$(get_ffmpeg_path)/ffmpeg" && \
# Side by side render
"$(get_ffmpeg_path)/ffmpeg" -hide_banner -y -i "${VOD_ID}/vod.mp4" -i "${VOD_ID}/chat.mp4" \
    -c:a copy -preset veryfast \
    -filter_complex "[0:v][1:v]hstack" \
    -r "$("$(get_ffmpeg_path)/ffprobe" -v quiet -of default=nk=1:nw=1 -select_streams v:0 -show_entries stream=r_frame_rate "${VOD_ID}/vod.mp4")" \
    "$([[ -n $OUTPUT ]] && echo -n $OUTPUT || echo -n "$VOD_ID.mp4")"
