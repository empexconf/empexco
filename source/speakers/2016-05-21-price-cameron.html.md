---
title: "Cameron Price"
topic: "Micropatterns: Learning to reach quickly for the right tool"
image: /assets/images/speakers/cameron-price.jpeg
link:
twitter: cameronp 
bio: "Cameron has been developing software since the 90's, using many different languages and platforms, but especially C, C++, Java, and Ruby.  In 2015 he discovered Elixir and the immutable paradigm.  Since then, he's been joyfully unlearning his imperative object-oriented instincts, and embracing the world of functional programming.  Cameron is currently the CTO of TRX.tv, and a director of Mint Digital and Boomf.com."
---
A lot of experienced programmers from non-functional backgrounds struggle when switching to languages like Elixir because the tools that have served them well for years have suddenly become useless in a world without object hierarchies or mutable state. This is expected. Musicians practice their scales, athletes drill basic movements, and chefs practice their knifework.  We programmers are not exempt from the need to hone our fundamentals.

We will look at several little patterns that are common in Elixir and take advantage of important Elixir features, such as pattern matching, first class functions, and tail recursion.  We'll see how these patterns can be quickly and instinctively deployed to solve real-world problems, along with tips on how to learn the patterns quickly and keep your skills sharp.  Some examples include:

* Quick and dirty file parsing using pattern matching
* Breaking down big problems into small mutations
* Recursing using an accumulator
* Writing reducer functions using `Enum.reduce_while` and `Stream.unfold`
* Pipelines (the one pattern everyone in the room already knows and loves and tries to apply everywhere)
* Happy path programming, in which we extract all the error handling into separate function heads, or let it crash
