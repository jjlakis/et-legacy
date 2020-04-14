FROM ubuntu AS download
RUN mkdir /etlegacy
WORKDIR /etlegacy

# Download ET: Legacy server files
RUN apt-get update && apt-get install -y curl unzip
RUN curl https://www.etlegacy.com/download/file/121 -o /etlegacy/etlegacy.tar.gz
RUN tar -xzf etlegacy.tar.gz

###

FROM ubuntu
RUN mkdir /etlegacy
WORKDIR /etlegacy

# Copy server files and assets
COPY --from=download /etlegacy/etlegacy-v2.76-x86_64 /etlegacy/

RUN mkdir -p /root/.etlegacy

CMD ["./etlded", "+set g_protect 1", "+set omnibot_enable 1", "+set omnibot_path \"./legacy/omni-bot\"", "+exec etl_server.cfg", "+set rcopassword s3cr3t", "+set sv_dlRate 8192", "+set team_maxlandmines 3", "+set g_gametype 3"]

EXPOSE 27960/udp
