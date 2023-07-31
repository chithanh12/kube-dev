# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Expose port 80 to allow communication
EXPOSE 80

# Set the NGINX_PORT environment variable with a default value of 80
ENV HOST_PORT=80

# Replace the default Nginx configuration file with a custom one
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Start Nginx with the specified port
# CMD ["sh", "-c", "envsubst '$$HOST_PORT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]