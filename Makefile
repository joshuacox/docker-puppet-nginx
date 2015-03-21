all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "   1. make build       - build the docker container"

build: builddocker beep

run: rundocker beep

rundocker:
	@docker run --name=dockerpuppetnginx \
	-P \
	-d \
	--cidfile="cid" \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t dockerpuppetnginx

builddocker:
	/usr/bin/time -v docker build -t dockerpuppetnginx .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

logs:
	@docker logs `cat cid`

rm-name:
	@docker rm name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm repo
	rm proxy
	rm proxyport

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash
