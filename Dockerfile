# Stage 1: Build Image (pour les dépendances)
FROM ruby:3.4.7 as builder

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

# Stage 2: Final Image
FROM ruby:3.4.7-slim

# Install system dependencies (slim version needs a minimal set)
RUN apt-get update -qq && apt-get install -y \
  postgresql-client \
  # Add other necessary libs for Active Storage, e.g., for image processing if you use it (like libvips or imagemagick)
  # libvips is often required for Active Storage variants
  libvips-dev \
  # Cleanup
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy built gems from the builder stage
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Copy the rest of the application code
COPY . .

# Expose port
EXPOSE 3004

# Entrypoint script (will be created in step 4)
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Default command to run the Rails server
CMD ["bundle", "exec", "rails", "s", "-p", "3004", "-b", "0.0.0.0"]