FROM elixir:alpine

EXPOSE 4000/tcp

ENV MIX_ENV=dev

# prepare build dir
RUN mkdir -p /srv/app

WORKDIR /srv/app

COPY . .

# this enables Phoenix live-reload
RUN apk add inotify-tools

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile

CMD mix phx.server
