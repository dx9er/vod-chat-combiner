#!/usr/bin/env bash

RES=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of default=nw=1:nk=1 "${VOD_ID}/vod.mp4")

VOD_WIDTH=$(echo "$RES" | awk 'NR==1')
VOD_HEIGHT=$(echo "$RES" | awk 'NR==2')

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
# Chat background: https://superuser.com/a/1221666
"$(get_ffmpeg_path)/ffmpeg" -y \
    -i "${VOD_ID}/chat.mp4" \
    -i "${VOD_ID}/chat_mask.mp4" \
    -i "${VOD_ID}/vod.mp4" \
    -filter_complex "[2]drawbox=x=$VOD_WIDTH-$([[ -n $CHAT_WIDTH ]] && echo -n "${CHAT_WIDTH}" || echo -n "340"):y=0:w=$([[ -n $CHAT_WIDTH ]] && echo -n "${CHAT_WIDTH}" || echo -n "340"):h=$VOD_HEIGHT:color=black@0.3:t=fill[vod_with_box];[0][1]alphamerge[ia];[vod_with_box][ia]overlay=main_w-overlay_w:0[out]" \
    -map '[out]' \
    -map '2:a' \
    "$([[ -n $OUTPUT ]] && echo -n "$OUTPUT" || echo -n "${VOD_ID}.mp4")"

