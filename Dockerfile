# Image de base Java 17 maintenue
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copier le JAR généré
COPY target/student-management-0.0.1-SNAPSHOT.jar app.jar

# Port exposé
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
