all: run

build:
	docker build -t my-dol-server .

run: build
	docker run --rm -it -v $(PWD)/data:/app/data --net=host my-dol-server:latest
