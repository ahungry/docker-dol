all: run

build:
	docker build -t my-dol-server .

run: build
	docker run --rm -it my-dol-server:latest
