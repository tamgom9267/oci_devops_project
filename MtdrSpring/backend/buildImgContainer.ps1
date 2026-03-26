docker stop agilecontainer -ErrorAction SilentlyContinue
docker rm -f agilecontainer -ErrorAction SilentlyContinue
docker rmi agileimage:0.1 -ErrorAction SilentlyContinue

mvn clean package -DskipTests
if (-not (Test-Path ".\target\MyTodoList-0.0.1-SNAPSHOT.jar")) {
    Write-Error "JAR not found: target\MyTodoList-0.0.1-SNAPSHOT.jar"
    exit 1
}

docker build -f DockerfileDev --platform linux/amd64 -t agileimage:0.1 .
docker run --name agilecontainer -p 8080:8080 -d agileimage:0.1
