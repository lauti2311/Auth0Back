# Define la etapa de construcción
FROM alpine:latest as build

RUN apk update
RUN apk add openjdk17

COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew bootJar --no-daemon

# Define la etapa de ejecución
FROM openjdk:17-alpine
EXPOSE 8080
COPY --from=build ./build/libs/auth0-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java", "-jar", "/app.jar", "-web -webAllowOthers -tcp -tcpAllowOthers -browser"]