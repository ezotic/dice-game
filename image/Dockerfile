# image/Dockerfile
FROM nginx:1.27-alpine

# Copy static site into the default Nginx web root
COPY ./site/ /usr/share/nginx/html/

# Optional: small hardening tweaks
# RUN adduser -D -H -u 10100 web && \
#     chown -R web:web /usr/share/nginx/html && \
#     sed -i 's/user  nginx;/user  nginx;/' /etc/nginx/nginx.conf

# Build arg used by Terraform to force rebuilds on file changes
ARG CACHEBUSTER
