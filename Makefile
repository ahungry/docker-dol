all: run

build:
	docker build -t my-dol-server .

run: build
	docker run --rm -it --net=host my-dol-server:latest
