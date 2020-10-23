docker build -t vjy0574/multi-client:latest -t vjy0574/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vjy0574/multi-server:latest -t vjy0574/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vjy0574/multi-worker:latest -t vjy0574/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vjy0574/multi-client:latest
docker push vjy0574/multi-server:latest
docker push vjy0574/multi-worker:latest

docker push vjy0574/multi-client:$SHA
docker push vjy0574/multi-server:$SHA
docker push vjy0574/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vjy0574/multi-server:$SHA
kubectl set image deployments/client-deployment client=vjy0574/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vjy0574/multi-worker:$SHA
