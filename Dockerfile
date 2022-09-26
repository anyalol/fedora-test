FROM ghcr.io/linuxserver/baseimage-rdesktop-web:fedora

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

RUN \
  echo "**** install packages ****" && \
  dnf install -y --setopt=install_weak_deps=False --best \
    breeze-icon-theme \
    dolphin \
    firefox \
    git \
    kate \
    kde-gtk-config \
    kde-settings-pulseaudio \
    khotkeys \
    kmenuedit \
    konsole5 \
    plasma-breeze \
    plasma-desktop \
    plasma-discover \
    plasma-workspace-xorg && \
  echo "**** cleanup ****" && \
  git clone --depth=1 -b fedora-kde https://github.com/linuxserver/docker-webtop . && \
  dnf autoremove -y && \
  dnf clean all && \
  rm -rf \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
