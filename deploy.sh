docker build -t wootoodoo/multi-client:latest -t wootoodoo/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t wootoodoo/multi-server:latest -t wootoodoo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wootoodoo/multi-worker:latest -t wootoodoo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wootoodoo/multi-client:latest
docker push wootoodoo/multi-server:latest
docker push wootoodoo/multi-worker:latest
docker push wootoodoo/multi-client:$SHA
docker push wootoodoo/multi-server:$SHA
docker push wootoodoo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=wootoodoo/multi-server:$SHA
kubectl set image deployments/client-deployment client=wootoodoo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wootoodoo/multi-worker:$SHA