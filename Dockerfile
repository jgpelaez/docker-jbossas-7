FROM dockerfile/java:oracle-java7

# Set the JBOSSAS_VERSION env variable
ENV JBOSSAS_VERSION 7.1.1.Final

# Create the jboss-as user and group
RUN groupadd -r jboss-as -g 433 && useradd -u 431 -r -g jboss-as -d /opt/jboss-as -s /sbin/nologin -c "WildFly user" jboss-as

# Create directory to extract tar file to
RUN mkdir /opt/jboss-as-$JBOSSAS_VERSION

# Add the WildFly distribution to /opt, and make jboss-as the owner of the extracted tar content
RUN cd /opt && \
	wget  http://repo1.maven.org/maven2/org/jboss/as/jboss-as-dist/$JBOSSAS_VERSION/jboss-as-dist-$JBOSSAS_VERSION.tar.gz  && \
	tar -C /opt -xzvf jboss-as-dist-$JBOSSAS_VERSION.tar.gz 

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/jboss-as-$JBOSSAS_VERSION /opt/jboss-as && chown -R jboss-as /opt/jboss-as

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jboss-as

# Expose the ports we're interested in
EXPOSE 8080 9990

# Run everything below as the jboss-as user
USER jboss-as

# Set the default command to run on boot
# This will boot JbossAs in the standalone mode and bind to all interface
CMD ["/opt/jboss-as/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
