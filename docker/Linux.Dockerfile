FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

# Install core dependencies
RUN apt-get update && \
    apt-get install -y \
        gcc g++ build-essential xorg wget libglib2.0-0 libx11-xcb-dev libglu1-mesa-dev libxkbcommon-x11-0 gettext wget && \
    rm -rf /var/lib/apt/lists/*

COPY bin/ /opt/qt-installer/bin
COPY templates/ /opt/qt-installer/templates

ENTRYPOINT ["/bin/bash", "/opt/qt-installer/bin/install-qt"]