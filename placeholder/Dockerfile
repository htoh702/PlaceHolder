FROM debian:latest

RUN apt-get update
RUN apt-get install -y curl git unzip

ARG FLUTTER_SDK=/usr/local/flutter
ARG FLUTTER_VERSION=3.22.2
ARG APP=/app/

RUN git clone  https://github.com/flutter/flutter.git $FLUTTER_SDK
RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN mkdir $APP

COPY . $APP

WORKDIR $APP

# RUN flutter clean
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs

EXPOSE 2040
ENTRYPOINT ["flutter", "run", "-d", "web-server", "--web-port", "2040", "--web-hostname", "0.0.0.0", "--web-renderer", "html"]