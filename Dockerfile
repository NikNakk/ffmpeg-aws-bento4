FROM jrottenberg/ffmpeg:latest AS base
RUN apt-get -yqq update \
   &&  apt-get -yq upgrade \
   &&  apt-get install -yq --no-install-recommends wget unzip bc groff-base less python3-minimal python3-httplib2 \
   &&  apt-get autoremove -y \
   &&  apt-get clean -y
RUN wget http://zebulon.bok.net/Bento4/binaries/Bento4-SDK-1-6-0-637.x86_64-unknown-linux.zip \
   &&  unzip Bento4-SDK-1-6-0-637.x86_64-unknown-linux.zip \
   &&  sed -i 's/return check_output(cmd)/return check_output(cmd, universal_newlines=True)/g' Bento4-SDK-1-6-0-637.x86_64-unknown-linux/utils/mp4utils.py \
   &&  mv Bento4-SDK-1-6-0-637.x86_64-unknown-linux/bin/* /usr/local/bin/ \
   &&  mv Bento4-SDK-1-6-0-637.x86_64-unknown-linux/lib/* /usr/local/lib/ \
   &&  mv Bento4-SDK-1-6-0-637.x86_64-unknown-linux/include/* /usr/local/include/ \
   &&  mv Bento4-SDK-1-6-0-637.x86_64-unknown-linux/docs /usr/local/ \
   &&  mv Bento4-SDK-1-6-0-637.x86_64-unknown-linux/utils /usr/local/ \
   &&  rm -r Bento4-SDK-1-6-0-637.x86_64-unknown-linux \
   &&  rm Bento4-SDK-1-6-0-637.x86_64-unknown-linux.zip
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
   &&  unzip "awscli-exe-linux-x86_64.zip" \
   &&  ./aws/install
RUN apt-get -yq remove wget unzip \
   &&  apt-get autoremove -y \
   &&  apt-get clean -y \
   &&  rm -rf /var/lib/apt/lists
COPY process-video /usr/local/bin/process-video
RUN chmod +x /usr/local/bin/process-video
ENTRYPOINT []
