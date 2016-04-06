---
title: "Cameron Price"
topic: "Micropatterns: Learning to reach quickly for the right tool"
image: /assets/images/speakers/cameron-price.png
link:
twitter: cameronp 
bio: Bio coming soon!
---
A lot of experienced programmers coming from non-Functional backgrounds struggle when they switch to languages like Elixir, because the tools that have served them well for years, have suddenly become useless in a world without object hierarchies or mutable state. This is to be expected.  Musicians have to practice their scales, athletes have to drill very basic movements, and chefs practice their knifework.  We programmers are not exempt from this need to focus on the small stuff.

I will present several little patterns that are quite common in Elixir, and take advantage of important Elixir features, such as pattern matching, first class functions, and tail recursion.  I show how these patterns can be quickly and instinctively deployed to solve real world problems, and I will offer some tips on how to learn the patterns quickly, and how to practice them and keep them sharp.  The exact patterns and number of patterns will depend on the length of the talk but the patterns may include:

Quick and dirty file parsing using pattern matching

Breaking down big problems into small mutations, using a state object and state mutators

Recursing using an accumulator

`Enum.reduce_while` and `Stream.unfold`... writing reducer functions.

Pipelines (the one pattern everyone in the room is guaranteed to already know and love, and try to apply everywhere)

Happy path programming, in which we extract all the error handling into separate function heads, or just let it crash.
