FROM debian:jessie

RUN apt-get update && \
    apt-get install -y --fix-missing python python-pip git python-dev inotify-tools && \
    rm -rf /var/lib/apt/lists/*

RUN pip install s3cmd klein

ADD s3cfg /root/.s3cfg

ADD start.sh /start.sh
RUN chmod +x /start.sh

ADD sync.sh /sync.sh
RUN chmod +x /sync.sh

ENTRYPOINT ["/start.sh"]
