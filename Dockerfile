FROM solr:5.4.0

#switch to root so we can do stuff
USER root

#install sql jdbc drivers
RUN mkdir temp && \
	cd temp && \
	curl -O https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_4.2.6420.100_enu.tar.gz && \
	tar -xvf sqljdbc_4.2.6420.100_enu.tar.gz && \
	mv ./sqljdbc_4.2/enu/sqljdbc42.jar ../server/solr/lib && \
	cd .. && \
	rm -rf temp

#add our config files
ADD ./src/jetty.xml /opt/solr/server/etc/
ADD ./src/log4j.properties /opt/solr/server/resources/
ADD ./src/solr.in.sh /opt/solr/bin/
ADD ./src/solr_entrypoint.sh ./
ADD ./src/link_data.sh ./

#create a directory for solr data
RUN mkdir /data

#make our entry point script executable and the script that symlinks to /data
RUN chmod 777 ./solr_entrypoint.sh
RUN chmod 777 ./link_data.sh

#add our cores on build
ONBUILD ADD ./cores/ /opt/solr/server/solr

#execute our script
CMD /bin/bash ./solr_entrypoint.sh