FROM alpine:edge

RUN apk --no-cache --update add \
  perl \
  ;

ARG \
  exiftool=10.69

RUN apk --no-cache --update add --virtual=build-deps \
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
  && apk del build-deps

ENTRYPOINT ["exiftool"]

WORKDIR /root
