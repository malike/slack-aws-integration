FROM openjdk:8
VOLUME /tmp
ADD target/slack-bot-0.0.1-SNAPSHOT.jar slack-bot-0.0.1-SNAPSHOT.jar
RUN sh -c 'touch /slack-bot-0.0.1-SNAPSHOT.jar'
ENV JAVA_OPTS="-Xms64m -Xmx256m"
EXPOSE 8080
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=docker -jar /slack-bot-0.0.1-SNAPSHOT.jar" ]