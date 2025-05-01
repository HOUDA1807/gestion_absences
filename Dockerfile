# 1. Base Java 17
FROM openjdk:17-jdk-slim

# 2. Travail dans /app
WORKDIR /app

# 3. Copie et compilation (Maven dans le container via Jenkins)
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 4. Expose le port de l’appli
EXPOSE 8080

# 5. Commande de démarrage
ENTRYPOINT ["java", "-jar", "target/gestion_absences-0.0.1-SNAPSHOT.jar"]
