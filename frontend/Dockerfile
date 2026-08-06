FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v

# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /app
WORKDIR /app
COPY . .

# Run build
RUN flutter pub get
RUN flutter build web

# Use Nginx to serve the build
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
# Provide a custom nginx config to read the PORT environment variable
COPY nginx.conf /etc/nginx/templates/default.conf.template
EXPOSE $PORT
CMD ["nginx", "-g", "daemon off;"]
