# Use an appropriate base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y tftpd-hpa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the TFTP port
EXPOSE 69/udp

# Start the TFTP server with the configuration file
CMD ["/usr/sbin/in.tftpd", "--foreground", "--user", "tftp", "--address", "0.0.0.0:69", "--secure", "/tftproot"]
