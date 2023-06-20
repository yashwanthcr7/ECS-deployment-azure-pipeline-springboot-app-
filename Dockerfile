# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline

# Copy the source code to the working directory
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Use a lightweight base image with Java
FROM openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/Springapp-3.1.0.jar .

# Set the command to run the application
CMD ["java", "-jar", "Springapp-3.1.0.jar"]
