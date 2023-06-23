# Site na Dark Web com Docker 🐳

## Introdução

Primeiramente para criar um servidor na rede onion, de maneira convencional, é necessário instalar o tor:

```bash
sudo apt install tor
```

Após ter instalado o tor é necessário configurar o arquivo de configuração do tor, que se encontra em `/etc/tor/torrc`. Para isso, abra o arquivo com seu editor de texto favorito e adicione as seguintes linhas:

```bash
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 localhost:80
```

Após ter configurado o arquivo de configuração do tor, reinicie o serviço:

```bash
sudo systemctl restart tor
```

Após a reinicialização do serviço, o tor irá criar as chaves de criptografia do servidor tor. Navegue ao diretório `/var/lib/tor/hidden_service/` e verifique se os arquivos `hostname` e `private_key` foram criados. O arquivo `hostname` contém o endereço do servidor tor, que será utilizado para acessar o site. O arquivo `private_key` contém a chave privada do servidor tor, que será utilizada para criptografar as mensagens que serão enviadas ao servidor tor. O algoritimo utilizado para gerar as chaves é o de HsEd25519, que é um algoritimo de curva elíptica.

A linha `HiddenServicePort` indica que qualquer serviço local na porta 80, será redirecionada para a porta 80 do servidor na rede tor. A linha `HiddenServiceDir` indica o diretório onde serão armazenadas as chaves de criptografia e dns `hostname` do servidor tor. Exemplo:

```bash
#/var/lib/tor/hidden_service/hostname
matrix6gj3i5dk42xjgqzd25pe5lo3654lf5wn76bfp2ns7klsaklvad.onion
```

Ao digitar o endereço acima no navegador tor, brave, você será redirecionado para o serviço que esta rodando em `localhost:80`. Pronto, você já tem um servidor na rede tor.

# Criação de servidor com docker e dominio personalizado

## Criação de domino personalizado

Sabendo das informações acima primeiramente, precisamos obter o dominio na rede onion. Para isso, iremos utilizar o mkp224o, que é um gerador de chaves para a rede onion. Para instalar o mkp224o, execute os seguintes comandos:

```bash
git clone https://github.com/cathugger/mkp224o.git
cd mkp224o
./autogen.sh
./configure && make
```

O comando acima será utilizado para um hardware mais simples, caso você tenha um hardware mais robusto, execute o seguinte comando:

```bash
git clone https://github.com/cathugger/mkp224o.git
cd mkp224o
./autogen.sh
./configure --enable-amd64-51-30k --enable-intfilter --enable-batchnum=7500000 && make
cp mkp224o /usr/local/bin
```

As configurações acima foram para um Rizen 7 5700G, com 8 núcleos, 16 threads e 32GB de RAM. A flag --enable-batchnum=7500000 é usada ao compilar o mkp224o para especificar o número de chaves que serão geradas em cada lote. Isso pode afetar o desempenho do mkp224o e a quantidade de memória RAM utilizada durante a geração das chaves. No exemplo que você acima, a flag --enable-batchnum=7500000 foi usada para gerar 7500000 chaves em cada lote, o que resultou em um uso de 28GB de RAM durante a execução do mkp224o. Consulte a [documentação](https://github.com/cathugger/mkp224o/blob/master/OPTIMISATION.txt) do mkp224o para obter mais informações sobre como otimizar a compilação para seu hardware.

Agora execute o comando

```bash
mkp224o -t 16 -d domains matrix
```

Será criado um diretório chamado `domains` com as chaves de criptografia e dns do servidor tor. Copie o arquivo `hostname` e as chaves para o diretório `/tor/hidden_service` deste projeto.

## Docke-compose

Faça o clone do repositório, renomeie a pasta com as chaves e o domínio hidden_service e copie para o diretório `/tor/hidden_service` na raiz do projeto, execute o comando:

```bash
docker-compose up --build
```

Se tudo ocorrer bem, você verá a página inicial do site, basta acessar o endereço encontrado no arquivo hostname em `hidden_service`. Exemplo: `matrix6gj3i5dk42xjgqzd25pe5lo3654lf5wn76bfp2ns7klsaklvad.onion`. Deverá ser acessado utilizando o navegador tor, brave, etc.

## Pagina exibida no navegador

[![image](./.assets/matrix.gif)](https://matrix6gj3i5dk42xjgqzd25pe5lo3654lf5wn76bfp2ns7klsaklvad.onion)
