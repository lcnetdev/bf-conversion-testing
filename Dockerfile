FROM alpine:3.12

RUN apk add --no-cache bash build-base libxslt libxslt-dev autoconf automake libtool bison gnu-libiconv libxml2 libxml2-dev libxml2-utils gnutls gnutls-dev tcl git

RUN cd /opt/ && git clone https://github.com/indexdata/yaz.git && cd yaz/ && git checkout tags/v5.30.3
RUN cd /opt/yaz/ && echo "SUBDIRS = src include util test client ztest zoom etc" >> Makefile.am && ./buildconf.sh && ./configure && make && make install

RUN adduser -D ndmso

USER ndmso
WORKDIR /home/ndmso/

COPY --chown=ndmso:ndmso lib/* /home/ndmso/lib/
COPY --chown=ndmso:ndmso marc2bibframe2/ /home/ndmso/marc2bibframe2/
COPY --chown=ndmso:ndmso bibframe2marc/ /home/ndmso/bibframe2marc/

RUN mkdir in out
RUN cd bibframe2marc && make

USER ndmso
WORKDIR /home/ndmso/