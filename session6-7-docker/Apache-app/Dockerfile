FROM httpd:2.4-alpine

# httpd serves from /usr/local/apache2/htdocs by default.
COPY index.html /usr/local/apache2/htdocs/index.html

EXPOSE 80
# The base image's own CMD already runs httpd in the foreground.
