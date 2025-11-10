FROM registry.access.redhat.com/ubi8/ubi:latest
# FROM python:3.13

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
