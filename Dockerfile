FROM elixir:1.15-slim

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV="prod"

COPY mix.exs mix.lock ./
RUN mix deps.get
COPY . .
RUN mix compile

CMD ["mix", "run", "--no-halt"]
