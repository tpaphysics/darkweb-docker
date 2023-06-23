# Use a imagem mais recente do Alpine
FROM alpine:latest

# Atualize a lista de pacotes e instale o Tor
RUN apk update && apk add tor

# Crie um novo usuário para executar o Tor
RUN adduser -D -g "" toruser

# Crie o diretório do serviço oculto no container e defina as permissões corretas
RUN mkdir /var/lib/tor/hidden_service && \
    chown -R toruser /var/lib/tor/hidden_service && \
    chmod 700 /var/lib/tor/hidden_service

# Copie o diretório do serviço oculto e o arquivo torrc para o container
COPY --chown=toruser ./hidden_service /var/lib/tor/hidden_service
COPY --chown=toruser ./torrc /etc/tor/torrc

# Alterne para o novo usuário e inicie o Tor quando o container for executado
USER toruser
CMD ["tor", "-f", "/etc/tor/torrc"]
