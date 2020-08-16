# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
    apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix deps.get --force
RUN mix compile

CMD ["/app/entrypoint.sh"]
