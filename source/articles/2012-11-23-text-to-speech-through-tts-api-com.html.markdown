---
title: Text.to_speech through tts-api.com
tagline:
date: 2012-11-23 09:09
comments: true
tags: Ruby, TTS, text-to-speech
description:
---

This extremely simple Ruby module extends the String class by adding a `to_speech` method, so `text.to_speech` will perform a request to [Text-to-Speech API](http://tts-api.com/) which produces a remote mp3 file that will be downloaded to the current directory (`curl` needed):

* `text.to_speech` &rarr; `text.mp3`

## Usage

<script src="http://gist.github.com/4065761.js"></script>

## Code

<script src="http://gist.github.com/4065761.js"></script>

