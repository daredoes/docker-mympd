############## runtime stage ##############
FROM giof71/mpd-alsa:latest

ENV MYMPD_SSL "false"
ENV MYMPD_HTTP_PORT "8080"
ENV MYMPD_HTTP_HOST "0.0.0.0"
COPY start.sh /start.sh
RUN chmod +x /start.sh
COPY additional-outputs.txt /user/config/additional-outputs.txt 
RUN apt-get update
RUN apt-get install -y lua5.4 lua5.4-dev
RUN apt-get install -y supervisor
COPY mympd_amd.deb /mympd.deb
RUN dpkg -i /mympd.deb && apt-get install -f
RUN mkdir /var/lib/mympd
RUN mkdir /var/lib/mympd/config
RUN printf $MYMPD_SSL > /var/lib/mympd/config/ssl
RUN printf $MYMPD_HTTP_PORT > /var/lib/mympd/config/http_port
RUN printf $MYMPD_HTTP_HOST > /var/lib/mympd/config/http_host
COPY supervisord.conf /etc/supervisord.conf
# RUN chmod +x /install-mympd.sh && bash /install-mympd.sh
EXPOSE 6600 8080 9001
ENV ALSA_OUTPUT_CREATE "no"
ENV ALSA_OUTPUT_ENABLED "no"

VOLUME /user/config /music /log /playlists /db
ENTRYPOINT [ "/start.sh" ]