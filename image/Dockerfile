FROM postgres:15

COPY ./script.sh /script.sh

RUN chmod +x /script.sh

USER 1000

CMD ["/script.sh"]
