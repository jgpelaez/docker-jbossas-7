FROM dockerfile/java:oracle-java7

# Set the JBOSSAS_VERSION env variable
ENV JBOSSAS_VERSION 7.1.1.Final

# This configuration is used for environments with proxy, 
# replaced by build.sh for the proxy env
#PROXYCONF1_HTTP
#PROXYCONF2_HTTPS


# Create directory to extract tar file to
RUN mkdir /opt/jboss-as-$JBOSSAS_VERSION && \
# Add the WildFly distribution to /opt, and make jboss-as the owner of the extracted tar content  \
    cd /opt && \
	wget  http://repo1.maven.org/maven2/org/jboss/as/jboss-as-dist/$JBOSSAS_VERSION/jboss-as-dist-$JBOSSAS_VERSION.tar.gz  && \
	tar -C /opt -xzvf jboss-as-dist-$JBOSSAS_VERSION.tar.gz  && \
	rm jboss-as-dist-$JBOSSAS_VERSION.tar.gz  && \
# Make sure the distribution is available from a well-known place \
	mv /opt/jboss-as-$JBOSSAS_VERSION /opt/jboss-as  && \
	mkdir /opt/jboss-as/standalone/data

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss-as

VOLUME ["/opt/jboss-as/standalone/deployments"]

# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot JbossAs in the standalone mode and bind to all interface
CMD ["/opt/jboss-as/bin/standalone.sh", "-b", "0.0.0.0"]
