FROM dockerfile/java:oracle-java7

# Set the JBOSSAS_VERSION env variable
ENV JBOSSAS_VERSION 8.1.0.Final

# Create the jbossas user and group
RUN groupadd -r jbossas -g 433 && useradd -u 431 -r -g jbossas -d /opt/jbossas -s /sbin/nologin -c "WildFly user" jbossas

# Create directory to extract tar file to
RUN mkdir /opt/jbossas-$JBOSSAS_VERSION

# Add the WildFly distribution to /opt, and make jbossas the owner of the extracted tar content
RUN cd /opt && \
	wget  http://repo1.maven.org/maven2/org/jboss/as/jboss-as-dist/$JBOSSAS_VERSION/jboss-as-dist-$JBOSSAS_VERSION.tar.gz  && \
	tar -C /opt -xzvf jboss-as-dist-$JBOSSAS_VERSION.tar.gz 

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/jbossas-$JBOSSAS_VERSION /opt/jbossas && chown -R jbossas:jbossas /opt/jbossas

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/jbossas

# Expose the ports we're interested in
EXPOSE 8080 9990

# Run everything below as the jbossas user
USER jbossas

# Set the default command to run on boot
# This will boot JbossAs in the standalone mode and bind to all interface
CMD ["/opt/jbossas/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
