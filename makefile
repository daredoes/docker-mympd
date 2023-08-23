DOCKER_IMAGE=mympd
DOCKER_REPO=daredoes
TAG_NAME=latest

run:
	docker run -d \
    -p 6600:6600 \
    -p 8080:8080 \
    -p 9001:9001 \
    --privileged \
    -v /Users/dare/Git/docker-mpd/config:/user/config \
    -v /Users/dare/Git/docker-mpd/music:/music \
    -v /Users/dare/Git/docker-mpd/db:/db \
    $(DOCKER_REPO)/$(DOCKER_IMAGE)


build:
	docker build --platform=linux/amd64 -t $(DOCKER_REPO)/$(DOCKER_IMAGE) .
	# docker build --platform=linux/arm64 -t $(DOCKER_REPO)/$(DOCKER_IMAGE) .

push:
	docker tag $(DOCKER_REPO)/$(DOCKER_IMAGE) $(DOCKER_REPO)/$(DOCKER_IMAGE):$(TAG_NAME)
	docker push $(DOCKER_REPO)/$(DOCKER_IMAGE):$(TAG_NAME)

.PHONY: build push 
