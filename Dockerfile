# Java 17 runtime
FROM eclipse-temurin:17-jre

# App directory
WORKDIR /app

# Copy the Spring Boot fat jar
COPY target/hello-api-1.0.0.jar app.jar

# Expose internal port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]
