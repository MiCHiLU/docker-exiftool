FROM alpine:3.7

WORKDIR /root

RUN apk --no-cache --update add \
  perl \
  ;

RUN exiftool_version="10.60" \
  ; apk --no-cache --update add --virtual=build-time-only \
  curl \
  tar \
  make \
  && mkdir src \
  && (cd src \
    && curl -s https://sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${exiftool_version}.tar.gz \
    | tar xzf - --strip-components 1 \
    && perl Makefile.PL \
    && make test \
    && make install \
  ) \
  && rm -rf src \
  && apk del build-time-only

ENTRYPOINT ["exiftool"]
