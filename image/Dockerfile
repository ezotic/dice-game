# image/Dockerfile
FROM nginx:1.27-alpine

# Build arg used by Terraform to force rebuilds on file changes
ARG CACHEBUSTER

# Copy static site into the default Nginx web root
COPY ./site/ /usr/share/nginx/html/

# Keep Nginx default startup behavior but lock static content to safe perms.
RUN chown -R nginx:nginx /usr/share/nginx/html && \
	chmod -R 755 /usr/share/nginx/html
