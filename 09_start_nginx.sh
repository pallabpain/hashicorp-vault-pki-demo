set -o xtrace

location=`pwd`

# Starts NGINX container with all the certs generated in 08_gen_certificate
# and configure it to use https over port 443
docker run -d \
    -v ${location}/web-server/certs:/etc/nginx/certs \
    -v ${location}/web-server/conf.d:/etc/nginx/conf.d \
    --name test.example.com -p 80:80 -p 443:443 \
    --network dev-network nginx

