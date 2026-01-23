FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalamos SSH Server y herramientas básicas (sin entorno gráfico pesado)
RUN apt update -y && apt install -y \
    openssh-server \
    sudo \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Configuración necesaria para SSH
RUN mkdir /var/run/sshd

# ⚠️ SEGURIDAD: Establecemos la contraseña de root a "root"
# CAMBIALA apenas entres si te importa la seguridad, pero para tu lab sirve.
RUN echo 'root:root' | chpasswd

# Permitimos login como root por SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH escucha en el 22
EXPOSE 22
# Dejamos el 8080 listo para tu API
EXPOSE 8080

# Levantamos el servicio SSH en primer plano
CMD ["/usr/sbin/sshd", "-D"]
