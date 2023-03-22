.PHONY: all build clean

all: build

out/:
	mkdir -p out

build: blog/* out/
	docker run \
		--rm \
		-v `pwd`/out:/out:rw \
		-v `pwd`/blog:/book:ro \
		-u `id -u ${USER}`:`id -g ${USER}` \
		`docker build -q .` \
		jupyter-book build --path-output /out /book >/dev/null

clean:
	rm -rf out/