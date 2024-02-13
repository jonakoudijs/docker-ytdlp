# Set the base image to Alpine
FROM python:3.12-alpine

# File Author / Maintainer
LABEL maintainer="Jona Koudijs"

# Install required packages
RUN pip install yt-dlp --no-cache-dir
RUN apk add coreutils ffmpeg --no-cache

# Set default container command
ENTRYPOINT ["yt-dlp"]
CMD ["--help"]
