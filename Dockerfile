FROM        ubuntu:18.04

WORKDIR     /tmp/workdir

RUN     apt-get -yqq update && \
        apt-get --no-install-recommends -yqq install xvfb && \
        rm -rf /var/lib/apt/lists/*

RUN     apt-get -yqq update && \
        apt-get --no-install-recommends -yqq install meshlab && \
        rm -rf /var/lib/apt/lists/*

ADD         xvfb_init /etc/init.d/xvfb
RUN         chmod a+x /etc/init.d/xvfb
ADD         xvfb_daemon_run /usr/bin/xvfb-daemon-run
RUN         chmod a+x /usr/bin/xvfb-daemon-run

ADD         meshlab.mlx /opt/meshlab.mlx

MAINTAINER  Colin McFadden <mcfa0086@umn.edu>

WORKDIR     /scratch/
CMD         ["--help"]
ENTRYPOINT  ["/usr/bin/xvfb-daemon-run"]
ENV         LD_LIBRARY_PATH=/usr/local/lib
ENV         DISPLAY :99
