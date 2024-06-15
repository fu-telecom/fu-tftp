# Use an appropriate base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y tftpd-hpa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the TFTP configuration file from ConfigMap
COPY tftpd-hpa.conf /etc/default/tftpd-hpa

# Create and set the TFTP root directory
RUN mkdir -p /tftproot && \
    chown -R tftp:tftp /tftproot

# Expose the TFTP port
EXPOSE 69/udp

# Start the TFTP server
CMD ["/usr/sbin/in.tftpd", "--foreground", "--user", "tftp", "--address", "0.0.0.0:69", "--secure", "/tftproot"]
