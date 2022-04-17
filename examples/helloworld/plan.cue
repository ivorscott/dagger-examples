package main

import (
    "dagger.io/dagger"
    "github.com/ivorscott/helloworld/pkg/hello"
)

dagger.#Plan & {
    // Say hello by writing to a file
    actions: {
        "hello": hello.#AddHello & {
            dir: client.filesystem.".".read.contents
        }
    }
    client: filesystem: ".": {
        read: contents: dagger.#FS
        write: contents: actions.hello.result
    }
}