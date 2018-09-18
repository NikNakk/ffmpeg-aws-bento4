FROM jrottenberg/ffmpeg:latest AS base
RUN apt-get -yqq update \
   &&  apt-get -yq upgrade \
   &&  apt-get install -yq --no-install-recommends wget unzip bc groff-base less python-minimal python-httplib2 \
   &&  apt-get autoremove -y \
   &&  apt-get clean -y
RUN wget http://zebulon.bok.net/Bento4/binaries/Bento4-SDK-1-5-1-624.x86_64-unknown-linux.zip \
   &&  unzip Bento4-SDK-1-5-1-624.x86_64-unknown-linux.zip \
   &&  mv Bento4-SDK-1-5-1-624.x86_64-unknown-linux/bin/* /usr/local/bin/ \
   &&  mv Bento4-SDK-1-5-1-624.x86_64-unknown-linux/lib/* /usr/local/lib/ \
   &&  mv Bento4-SDK-1-5-1-624.x86_64-unknown-linux/include/* /usr/local/include/ \
   &&  mv Bento4-SDK-1-5-1-624.x86_64-unknown-linux/docs /usr/local/ \
   &&  mv Bento4-SDK-1-5-1-624.x86_64-unknown-linux/utils /usr/local/ \
   &&  rm -r Bento4-SDK-1-5-1-624.x86_64-unknown-linux \
   &&  rm Bento4-SDK-1-5-1-624.x86_64-unknown-linux.zip
RUN wget -O - https://bootstrap.pypa.io/get-pip.py | python
RUN pip install awscli
RUN yes | pip uninstall pip setuptools
RUN apt-get -yq remove wget unzip \
   &&  apt-get autoremove -y \
   &&  apt-get clean -y \
   &&  rm -rf /var/lib/apt/lists
COPY process-video /usr/local/bin/process-video
RUN chmod +x /usr/local/bin/process-video
ENTRYPOINT []
