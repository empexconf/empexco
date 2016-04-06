---
title: "Pete Gamache"
topic: "Real World Elixir Deployment"
image: /assets/images/speakers/pete-gamache.jpg
link:
twitter: gamache
bio: "Pete is head of engineering at Appcues, and brings over a decade of LabVIEW, FORTRAN 77, and Perl experience to the Elixir community. He's written literally dozens of codes, and his favorite language so far is this one. Follow him on Twitter."
---
The Elixir community commonly remarks that deploying Elixir is easy, with noticeably few details about how it's actually done.

The unsavory truth is that many of us are using a deployment "system" consisting of something like `tmux` + `git pull` + `mix phoenix.server`, thereby gaining few of the deployment advantages of the Erlang/Elixir platform.

This talk explains how to deploy Elixir in a real-world production setting, including releases, rolling and hot upgrades, rollbacks, clustering, and fault tolerance.  We will also cover the numerous gotchas you may encounter on your way to creating a bulletproof service.
