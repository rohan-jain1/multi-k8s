docker build -t rjai/multi-client:latest -t rjai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rjai/multi-server:latest -t rjai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rjai/multi-worker:latest -t rjai/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rjai/multi-client:latest
docker push rjai/multi-server:latest
docker push rjai/multi-worker:latest

docker push rjai/multi-client:$SHA
docker push rjai/multi-server:$SHA
docker push rjai/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rjai/multi-server:$SHA
kubectl set image deployments/client-deployment client=rjai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rjai/multi-worker:$SHA
