# Utilise une image de base OpenJDK 17
FROM openjdk:17-jdk-slim

# Crée l’utilisateur non-root pour exécuter l’appli
RUN useradd -ms /bin/bash appuser
USER appuser

# Crée et définit le répertoire de travail
WORKDIR /home/appuser/app

# Copie les sources et compile (si projet Java/Maven)
# Si tu as un jar préconstruit, adapte ici
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Expose le port 8080
EXPOSE 8080

# Point d’entrée
ENTRYPOINT ["java", "-jar", "target/gestion_absences-0.0.1-SNAPSHOT.jar"]
