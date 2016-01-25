FROM axeclbr/java:jdk8

# Set LEIN_ROOT to disable warning if run as root
ENV LEIN_ROOT 1

# Install Leiningen stable
RUN apt-get update && apt-get install -y \
    curl \
 && curl -L "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" -o /usr/local/bin/lein \
 && chmod 0744 /usr/local/bin/lein \
 && lein upgrade \
 && apt-get -y remove curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["/usr/local/bin/lein", "version"]

