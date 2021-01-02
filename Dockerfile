FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY . /app/.
RUN mvn install
ENTRYPOINT java -jar /app/hello-world-app/target/hello-world-app-0.0.1-SNAPSHOT.jar 
