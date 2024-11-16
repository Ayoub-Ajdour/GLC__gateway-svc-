# stage 1
FROM maven:3.8.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# 2
FROM eclipse-temurin:17-jre-alpine
COPY --from=builder /app/target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
