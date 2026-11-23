#!/usr/bin/env bash
# Run individual recipes after replacing input.mp4. Review crop suitability first.
# Requires FFmpeg with libx264; the subtitle recipe also requires libass.
# Extract a 30-second candidate beginning at 00:01:15.
ffmpeg -ss 00:01:15 -i input.mp4 -t 30 -c:v libx264 -crf 20 -c:a aac clip.mp4
# Center-crop a landscape clip to 9:16. Check that the subject stays in frame.
ffmpeg -i clip.mp4 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" -c:v libx264 -crf 20 -c:a aac vertical.mp4
# Burn an edited SRT into the vertical clip. Check timing and safe areas.
ffmpeg -i vertical.mp4 -vf "subtitles=captions.srt:force_style='FontSize=18,Outline=2,MarginV=80'" -c:v libx264 -crf 20 -c:a copy captioned.mp4
