# Initialize variables with default values
port=$1

echo "run docker with hostport = $port"

docker run -p 80:80 -e HOST_PORT=$port my_nginx

