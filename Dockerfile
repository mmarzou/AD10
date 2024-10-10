FROM debian:12.5

# Installation des paquets nécessaires
RUN apt-get update && apt-get install -y openssh-server sudo

# Création du répertoire pour SSHD
RUN mkdir /var/run/sshd

# Définition du mot de passe pour root
RUN echo 'root:root' | chpasswd

# Configuration de SSH pour autoriser la connexion en tant que root et par mot de passe
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Ouverture du port 22 pour SSH
EXPOSE 22

# Démarrage du serveur SSH
CMD ["/usr/sbin/sshd", "-D"]