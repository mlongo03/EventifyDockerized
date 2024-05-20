FROM maven:3.9.1-eclipse-temurin-17-alpine AS build

COPY serverEventify /serverEventify
RUN mvn -f /serverEventify/pom.xml clean package -DskipTests

FROM eclipse-temurin:17-jdk

COPY --from=build serverEventify/target/app-eventify.jar /app-eventify.jar

CMD ["java", "-jar", "app-eventify.jar"]
