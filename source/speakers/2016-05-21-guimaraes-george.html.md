---
title: "George Guimaräes"
topic: "Async Jobs in Phoenix"
image: /assets/images/people/george-guimaraes.jpg
link:
twitter: georgeguimaraes
bio: "George is co-founder at Plataformatec, a software consultancy in Elixir and Ruby. His favorites topics are Discrete Integration, monoliths, and picoservices with Elixir."
---
It is inevitable. You'll end up needing to do some tasks in background. Maybe it's an email you need to send. Maybe it's a image resizing. Maybe it's a business rule that doesn't need to run in the web request.

In this talk, we're gonna see some options to accomplish that. Ranging from how you can use `Task.async` or `Task.Supervisor` to fire-and-forget tasks, to using an "external" queue and workers like `exq`. 

We'll see code and test examples in Elixir/Phoenix.

More importantly than the tools, I'll show what kind of questions you need to ask to decide on what tool will fit your needs.
