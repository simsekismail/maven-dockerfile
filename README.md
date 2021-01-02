# maven-dockerfile
### BUILD Dockerfile
```
docker build -t [image_name] .
```
### RUN
```
docker run -d -p 8080:8080 maven
```
### Invoke
```
curl -H "Content-Type: text/plain" -d World localhost:8080/
```
