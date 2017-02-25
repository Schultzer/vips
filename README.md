# Vips

Elixir wrapper for [VIPS](http://www.vips.ecs.soton.ac.uk/index.php) command line.

[![Build Status](https://travis-ci.org/Schultzer/vips.svg?branch=master)](https://travis-ci.org/Schultzer/vips)

## Example

```elixir
import Vips

open("example.jpg")
|> rotate("d180")
|> save([:tmp])

```

## Getting started

`$ brew install vips`

Add `vips` to your list of dependencies in `mix.exs`

```elixir
def deps do
  [{:vips, "~> 0.1.0"}]
end
```

Now run:
`mix do deps.get, deps.compile`

## Limitation
VIPS does not support piping of functions.

Invalid:
```elixir
open("example.jpg")
|> rotate("d180")
|> png
|> save([:tmp])
```

Valid:
```elixir
open("example.jpg")
|> png
|> save([:tmp])
```

## Documentation

For [libvips](http://www.vips.ecs.soton.ac.uk/supported/current/doc/html/libvips/)

For hexdocs:
[VIPS](http://hexdocs.pm/vips)


## Tests

`$ mix test`

## LICENSE

(The MIT License)

Copyright (c) 2017 Benjamin Schultzer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
