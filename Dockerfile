FROM nodered/node-red-docker
RUN npm install node-red-node-wordpos

USER root
RUN apt-get update && apt-get install -y jq

USER node-red

# Copy entrypoint scripts
COPY --chown=node-red docker-entrypoint.sh /opt/eugenio/
COPY --chown=node-red docker-entrypoint.d/* /opt/eugenio/docker-entrypoint.d/

# Copy node-red data files
COPY --chown=node-red data/* /data/

ENTRYPOINT ["/opt/eugenio/docker-entrypoint.sh"]
CMD ["npm", "start", "--", "--userDir", "/data"]
