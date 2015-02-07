FROM joelpm/baseimage-nodejs

# Add the NodeJS runit script
RUN mkdir /etc/service/nodejs
ADD nodejs.sh /etc/service/nodejs/run

# Create the nodejs user and group
RUN groupadd -r nodejs -g 432 && \
    useradd -u 431 -r -g nodejs -m -d /home/nodejs -s /sbin/nologin -c "Docker image user" nodejs && \
    chown -R nodejs:nodejs /home/nodejs

# Set the working dir and add the app files to it
# TODO: figure out why NPM installs stuff to /root/.npm/ and can't run as user nodejs
WORKDIR /home/nodejs/app
ONBUILD ADD . /home/nodejs/app
ONBUILD USER root
ONBUILD RUN pwd && npm install
ONBUILD RUN whoami && chown -R nodejs:nodejs /home/nodejs

USER nodejs

EXPOSE 3000
