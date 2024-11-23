# Base image
FROM node:16

# Diretório de trabalho
WORKDIR /app

# Copiar dependências
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar código
COPY . .

# Expõe a porta usada pela aplicação
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["npm", "start"]
