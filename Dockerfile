# Start with a barebone version of Ruby
FROM ruby:2.3.3-slim

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
RUN apt-get update -qq && apt-get install -y build-essential nodejs

# Environment variable for the install path of the app inside the Docker image
ENV INSTALL_PATH /banners
RUN mkdir -p INSTALL_PATH

# Set the working directory
WORKDIR INSTALL_PATH

# Copy the Gemfile and install the gems with bundle
COPY Gemfile Gemfile
RUN bundle install

# Copy the rest of the project
COPY . .
