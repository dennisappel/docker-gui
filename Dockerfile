FROM ubuntu AS base

RUN 	apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository ppa:webupd8team/java# && \
	#echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
	apt-get install -y xvfb \
	dbus-x11 \
	x11-utils \
	libswt-gtk-3-java \
	ca-certificates \
	# oracle-java8-installer \
	xdotool \
	xclip \
	openbox \
	openjdk-11-jre \
	scrot && \
	#update-java-alternatives -s java-8-oracle && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM base AS gui

COPY client /client

ENV JAR_FILE PlatinGUI740Linux_7.JAR

RUN 	chmod +x /client/install.sh && \
	mkdir /gui && \
	/client/install.sh

FROM gui AS final

COPY scripts /scripts

RUN chmod +x /scripts* && \
    mkdir /results

WORKDIR /results

ENTRYPOINT ["/scripts/entrypoint.sh"]
