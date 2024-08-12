# Usa una imagen base de Ubuntu
FROM ubuntu:22.04

# Definimos los argumentos
ARG UID
ARG GID
ARG MY_USER_NAME

# Actualizamos los repositorios e instalamos sudo y adduser
RUN apt-get update && \
    apt-get install -y sudo adduser curl gnupg && \
    groupadd --gid $GID $MY_USER_NAME && \
    useradd --uid $UID --gid $GID --create-home --shell /bin/bash $MY_USER_NAME && \
    echo "$MY_USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cambiamos al nuevo usuario
USER $MY_USER_NAME

# Establecemos el directorio de trabajo
WORKDIR /home/$MY_USER_NAME/app

# Copiamos los archivos al contenedor
COPY --chown=$MY_USER_NAME:$MY_USER_NAME . /home/$MY_USER_NAME/app

# Ajustamos los permisos de los archivos copiados
RUN chmod -R 764 /home/$MY_USER_NAME/app

# Creamos el directorio requerido y ajustamos permisos (opcional)
RUN mkdir -p /home/$MY_USER_NAME/app/todos && \
    chown -R $MY_USER_NAME:$MY_USER_NAME /home/$MY_USER_NAME/app/todos

# Instala las dependencias del proyecto
RUN yarn install --production

# Exponemos el puerto que usa la aplicación (ajusta según sea necesario)
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "src/index.js"]
