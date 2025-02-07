FROM maven:3.9-eclipse-temurin-17 AS build
COPY . /spc
WORKDIR /spc
RUN mvn package

FROM eclipse-temurin:17-jdk-alpine  as builder
LABEL project="axisbank"
LABEL author="shyam"
ARG USERNAME=spc
RUN adduser -D -h /mydata -s /bin/sh ${USERNAME}
USER ${USERNAME}
COPY --from=build --chown=${USERNAME}:{USERNAME} /spc/target/spring-petclinic-3.4.0-SNAPSHOT.jar /mydata/spring-petclinic-3.4.0-SNAPSHOT.jar
WORKDIR /mydata
EXPOSE 8080
CMD ["java", "-jar","spring-petclinic-3.4.0-SNAPSHOT.jar"]