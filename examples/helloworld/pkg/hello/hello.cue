// dagger do hello --log-format=plain
//
// 9:06AM INF actions._alpine | computing
// 9:06AM INF actions._alpine | completed    duration=1s
// 9:06AM INF actions.hello | computing
// 9:06AM INF actions.hello | #3 0.073 hello, world!
// 9:06AM INF actions.hello | completed    duration=100ms

package hello

import (
    "dagger.io/dagger"
    "dagger.io/dagger/core"
)

// Write a greeting to a file, and add it to a directory
#AddHello: {
    // The input directory
    dir: dagger.#FS

    // The name of the person to greet
    name: string | *"world"

    write: core.#WriteFile & {
        input: dir
        path: "hello-\(name).txt"
        contents: "hello, \(name)!"
    }

    // The directory with greeting message added
    result: write.output
}