# Chaos Game

```
In mathematics, the term chaos game originally referred to a method of creating a fractal, using a polygon and an initial point selected at random inside it.
```
[Chaos Game (mathematics) on Wikipedia](https://en.wikipedia.org/wiki/Chaos_game)

Simple implementation of a chaos game with a rectangular polygon and a fraction of 1/2. The only rule is that the next random vertex cannot be the same as the last vertex, resulting in a nice latticework fractal. Uses Scenic framework for rendering.

Install dependencies:
```
mix deps.get
```

Run with:
```
mix scenic.run
```
