docker build -t syed9008572790/multi-client-k8s:latest -t syed9008572790/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t syed9008572790/multi-server-k8s-pgfix:latest -t syed9008572790/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t syed9008572790/multi-worker-k8s:latest -t syed9008572790/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push syed9008572790/multi-client-k8s:latest
docker push syed9008572790/multi-server-k8s-pgfix:latest
docker push syed9008572790/multi-worker-k8s:latest

docker push syed9008572790/multi-client-k8s:$SHA
docker push syed9008572790/multi-server-k8s-pgfix:$SHA
docker push syed9008572790/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=syed9008572790/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=syed9008572790/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=syed9008572790/multi-worker-k8s:$SHA
