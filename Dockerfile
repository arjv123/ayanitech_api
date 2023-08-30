# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs nano postgresql-client

RUN mkdir /ayanitech_api

# Set the working directory in the container
WORKDIR /ayanitech_api

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the Rails API will run
EXPOSE 3000

# Start the Rails server
CMD rails server -b 0.0.0.0 --port 3000
