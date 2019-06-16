FROM dapl/gui AS gui

ARG JAVA_DIR
ARG JRE
ARG JRE_FILE
ARG JAR

COPY client /client

RUN 	chmod +x /client/install.sh && \
	mkdir /gui $JAVA_DIR && \
	tar xzf /client/$JRE_FILE -C $JAVA_DIR/ && \
	update-alternatives --install /usr/bin/java java $JAVA_DIR/$JRE/bin/java 1  && \
	update-alternatives --install /usr/bin/javaws javaws $JAVA_DIR/$JRE/bin/javaws 1 && \
	update-alternatives --set java $JAVA_DIR/$JRE/bin/java && \
	update-alternatives --set javaws $JAVA_DIR/$JRE/bin/javaws && \
	/client/install.sh $JAR

FROM gui AS final

COPY scripts /scripts

RUN chmod +x /scripts* && \
	mkdir /results

WORKDIR /results

ENTRYPOINT ["/scripts/entrypoint.sh"]
