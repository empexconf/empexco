---
title: "George Guimaräes"
topic: "Async Jobs in Phoenix"
image: /assets/images/people/george-guimaraes.jpg
link:
twitter: georgeguimaraes
interview: "https://medium.com/@EmpEx/jinterview-with-empex-speaker-george-guimar%C3%A3es-a0e870bf9a20#.2gjdunuup"
bio: "George is co-founder at Plataformatec, a software consultancy in Elixir and Ruby. His favorite topics are Discrete Integration, monoliths, and picoservices with Elixir."
headline: true
---
It's inevitable: you'll need to do some tasks in background. Maybe it's an email you need to send. Maybe it's an image resizing. Maybe it's a business rule that doesn't need to run in the web request.

In this talk, we'll code and test implementations for these patterns in Elixir/Phoenix, ranging from how you can use `Task.async` or `Task.Supervisor` for fire-and-forget tasks, to using an "external" queue and workers like `exq`. 

More importantly than the tools, we'll examine the kinds of questions you need to ask to decide which tool will fit your needs.
