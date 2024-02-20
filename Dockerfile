######## BUILDER ########

# Set the base image
FROM alpine as builder

# Install prerequisites
RUN apk add curl --no-cache

# Download and unpack installer
RUN curl https://github.com/yt-dlp/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz \
    --output ffmpeg.tar.xz --location --silent
RUN tar -xf ffmpeg.tar.xz && rm ffmpeg.tar.xz

######## INSTALL ########

# Set the base image to Debian slim
FROM python:3.12-slim

# File Author / Maintainer
LABEL maintainer="Jona Koudijs"

# Install required packages
RUN pip install yt-dlp --no-cache-dir

# Copy ffmpeg files from builder
COPY --from=builder /ffmpeg-master-latest-linux64-gpl/bin /usr/local/bin/

# Set default container command
ENTRYPOINT ["yt-dlp"]
CMD ["--help"]
