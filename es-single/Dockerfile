FROM centos:centos7
COPY essetup-single.sh /tmp
RUN chmod 755 /tmp/essetup-single.sh
ENTRYPOINT ["/tmp/essetup-single.sh"]
CMD [ "/sbin/init" ]
