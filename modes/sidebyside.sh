#!/usr/bin/env bash

$(twitch_dl "chatrender") -i "${VOD_ID}/chat.json" -o "${VOD_ID}/chat.mp4" \
    -w 340 -h 1080 \
    --update-rate 0 --dispersion true \
    $([[ -n $EMOJI_VENDOR ]] && echo -n "--emoji-vendor "${EMOJI_VENDOR}"") \
    $([[ -n $CHAT_FONT ]] && echo -n "--font "${CHAT_FONT}"") \
    --ffmpeg-path "$([[ -n $FFMPEG_PATH ]] && echo -n "${FFMPEG_PATH}/ffmpeg" || echo -n "${COMBINER_DIR}/bin/ffmpeg")" && \
# Side by side render
ffmpeg -hide_banner -y -i "${VOD_ID}/vod.mp4" -i "${VOD_ID}/chat.mp4" -filter_complex hstack \
    "$([[ -n $OUTPUT ]] && echo -n $OUTPUT || echo -n "$VOD_ID.mp4")"
