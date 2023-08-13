# Randomness in Cairo

## Basic hash based approach

Easiest way to get a random number is to start with some input (maybe a counter?) and hash it. And there you go, you have several bits of randomness right there. This is what I've had in my projects like [`dojo-shooter`](https://github.com/shramee/dojo-shooter) to, say, pick the coordinates where a zombie spawns.
This works fine for trivial games but I can easily predict exactly where the zombies will spawn well before the game starts.
You can use randomness from other contracts as salt. But idea is pretty much the same.

[Implementation in ./src/hash.cairo](src/hash.cairo)

