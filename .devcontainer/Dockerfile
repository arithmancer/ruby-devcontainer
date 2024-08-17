FROM mcr.microsoft.com/vscode/devcontainers/ruby:3.3-bullseye

COPY *.crt '/usr/local/share/ca-certificates/'
RUN update-ca-certificates
ENV NODE_EXTRA_CA_CERTS='/etc/ssl/certs/ca-certificates.crt'
