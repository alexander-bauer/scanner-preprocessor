FROM dpokidov/imagemagick:latest-ubuntu
COPY entrypoint.sh /entrypoint.sh
VOLUME /from
VOLUME /to
ENTRYPOINT ["/entrypoint.sh"]
