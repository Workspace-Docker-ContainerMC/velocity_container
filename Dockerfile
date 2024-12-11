FROM docker.io/eclipse-temurin:17-jdk-ubi9-minimal as build

RUN microdnf install findutils git -y && microdnf clean all \
    && git config --global user.name "Automated build" && git config --global user.email "build@example.com" \
    && git clone https://github.com/PaperMC/Velocity.git -b dev/3.0.0

WORKDIR /Velocity

RUN ./gradlew build

FROM docker.io/redhat/ubi9-minimal as production

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV JAVA_HOME=/opt/graalvm-17

RUN microdnf install -y binutils tzdata openssl wget ca-certificates fontconfig glibc-langpack-en gzip tar \
    freetype dejavu-sans-mono-fonts unzip \
    && microdnf clean all \
    && mkdir /opt/graalvm-17

RUN curl -L https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13%2B11/OpenJDK17U-jdk_x64_linux_hotspot_17.0.13_11.tar.gz | \
    tar --strip-components 1 \
    --ungzip \
    --extract \
    --directory "$JAVA_HOME" \
    && update-alternatives --install /usr/bin/java java "$JAVA_HOME"/bin/java 2000 \
    && update-alternatives --install /usr/bin/javac javac "$JAVA_HOME"/bin/javac 2000 \
    && update-alternatives --install /usr/bin/jar jar "$JAVA_HOME"/bin/jar 2000

RUN mkdir /app \
	&& echo "eula=true" > /app/eula.txt

COPY --from=build /Velocity/proxy/build/libs/velocity-proxy-*-SNAPSHOT-all.jar /app/velocity.jar

WORKDIR /proxy
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]
