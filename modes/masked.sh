#!/usr/bin/env bash

$(twitch_dl "chatrender") -i "${VOD_ID}/chat.json" -o "${VOD_ID}/chat.mp4" \
    -w 340 -h 1080 \
    --update-rate 0 --dispersion true \
    --emoji-vendor "$([[ -n $EMOJI_VENDOR ]] && echo -n "--emoji-vendor ${EMOJI_VENDOR}" || echo -n "notocolor")" \
    $([[ -n $CHAT_FONT ]] && echo -n "--font "${CHAT_FONT}"") \
    --outline true --generate-mask --background-color '#00000000' \
    --ffmpeg-path "$([[ -n $FFMPEG_PATH ]] && echo -n "${FFMPEG_PATH}/ffmpeg" || echo -n "${COMBINER_DIR}/bin/ffmpeg")" && \
# Render with masked chat
# https://github.com/lay295/TwitchDownloader/issues/79#issuecomment-699648513
ffmpeg -y  -i "${VOD_ID}/vod.mp4" -i "${VOD_ID}/chat.mp4" -i "${VOD_ID}/chat_mask.mp4" \
    -c:a copy -preset veryfast \
    -filter_complex '[1][2]alphamerge[ia];[0][ia]overlay=main_w-overlay_w:main_h-overlay_h' \
    "$([[ -n $OUTPUT ]] && echo -n "$OUTPUT" || echo -n "${VOD_ID}.mp4")"
