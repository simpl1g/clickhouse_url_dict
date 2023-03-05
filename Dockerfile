FROM ruby:3.2-slim

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential

WORKDIR /opt/apps/api

RUN gem install bundler:2.4.7

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma", "-v"]
