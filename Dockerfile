FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    rclone \
    fuse \
    gerbera \
    && apt-get clean

# Create necessary directories
RUN mkdir -p /mnt/onedrive

# Set up environment variables for rclone and mount path
ENV RCLONE_CONFIG_PATH="/config/rclone/rclone.conf"
ENV RCLONE_REMOTE_NAME="remote_name"
ENV MOUNT_PATH="/mnt/onedrive"
ENV GERBERA_CONFIG_PATH="/config/gerbera"

# Expose the necessary ports for Gerbera and DLNA
EXPOSE 8080
EXPOSE 1900/udp
EXPOSE 7878

# Run the rclone mount and Gerbera server in the background
CMD rclone mount $RCLONE_REMOTE_NAME:/ $MOUNT_PATH --vfs-cache-mode writes --allow-other & \
    gerbera
