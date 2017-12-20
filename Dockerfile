FROM alpine:edge

WORKDIR /root

RUN apk --no-cache --update add \
  perl \
  ;

ARG \
  exiftool=10.68

RUN apk --no-cache --update add --virtual=build-time-only \
  curl \
  tar \
  make \
  && mkdir src \
  && (cd src \
    && curl -s https://sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${exiftool}.tar.gz \
    | tar xzf - --strip-components 1 \
    && perl Makefile.PL \
    && make test \
    && make install \
  ) \
  && rm -rf src \
  && apk del build-time-only

ENTRYPOINT ["exiftool"]
