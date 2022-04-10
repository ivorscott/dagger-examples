package main

import (
	"dagger.io/dagger"
	"dagger.io/dagger/core"
)

dagger.#Plan & {
	actions: {
		pull: core.#Pull & {
			source: "alpine:3.15.0@sha256:e7d88de73db3d3fd9b2d63aa7f447a10fd0220b7cbf39803c803f2af9ba256b3"
		}
		write: core.#WriteFile & {
			input:       pull.output
			path:        "/testing"
			contents:    "1,2,3"
			permissions: 700
		}
		readfile: core.#ReadFile & {
			input: write.output
			path:  "/testing"
		} & {
			// assert result
			contents: "1,2,3"
		}
	}
}
