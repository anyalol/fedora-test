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
    wget \
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
  dnf autoremove -y && \
  dnf clean all && \
  rm -rf \
    /tmp/*

# add local files
RUN mkdir root root/defaults && wget -P root/defaults/ https://github.com/linuxserver/docker-webtop/raw/fedora-kde/root/defaults/startwm.sh
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
