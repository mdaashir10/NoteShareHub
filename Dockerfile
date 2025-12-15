# ============================
# STAGE 1: Build the WAR
# ============================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package

# ============================
# STAGE 2: Run on Tomcat
# ============================
FROM tomcat:9.0-jdk17-temurin

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Create admin user that MATCHES web.xml (role = admin)
RUN sed -i '/<\/tomcat-users>/i \
<role rolename="admin"/> \
<user username="admin" password="admin123" roles="admin"/>' \
/usr/local/tomcat/conf/tomcat-users.xml

# Deploy WAR as ROOT
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Directory for uploaded notes
RUN mkdir -p /var/notes && chmod -R 777 /var/notes

EXPOSE 8080
CMD ["catalina.sh", "run"]