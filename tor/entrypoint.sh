#!/bin/sh
# entrypoint.sh

# Inicia o Tor
exec tor -f /etc/tor/torrc


#https://metrics.torproject.org/rs.html#search/flag:exit   NÓS DE SAÍDA
#https://metrics.torproject.org/rs.html#search/DE  NÓS NA ALEMANHA