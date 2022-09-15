# syntax=docker/dockerfile:1
FROM ruby:2.5 AS builder
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY /myapp/ /myapp/
RUN bundle install

# Multi-stage build step
FROM ruby:2.5
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /myapp/ /myapp/
COPY database.yml /myapp/config/database.yml

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

