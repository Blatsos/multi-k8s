docker build -t blatsosinf/multi-client:latest -t blatsosinf/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t blatsosinf/multi-server:latest -t blatsosinf/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t blatsosinf/multi-worker:latest -t blatsosinf/multi-worker:$SHA -f ./worker/Dockerfile/dev ./worker

docker push blatsosinf/multi-client:latest
docker push blatsosinf/multi-server:latest
docker push blatsosinf/multi-worker:latest

docker push blatsosinf/multi-client:$SHA
docker push blatsosinf/multi-server:$SHA
docker push blatsosinf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=blatsosinf/multi-server:$SHA
kubectl set image deployments/client-deployment client=blatsosinf/multi-client:$SHA
kubectl set imag deployments/worker-deployment worker=blatsosinf/multi-worker:$SHA