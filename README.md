# Code Sharing

A full-stack Dart application using Flutter on the client and
[`shelf`](https://pub.dev/packages/shelf) on the server. The Flutter app
itself is still the counter app, but the actual number is stored on the server
and incremented over HTTP using transport data classes understood by both the
Flutter client and shelf server.

## Goals

The goal of this sample is to demonstrate the mechanics of sharing business
logic between a Flutter client and a Dart server. The sample also includes a
slightly modified Dockerfile which is required to build a Docker image from
a Dart app containing nested packages.

## Project Structure

The sample's project structure is as follows:

```
code_sharing/
  # Flutter app
  client/
    lib/
      ...
    pubspec.yaml
    ...
  # Shelf
  server/
    bin/
      server.dart
    pubspec.yaml
    Dockerfile
  # Common business logic
  shared/
    pubspec.yaml
    lib/
      ...
```

<!-- ## Preview
<p align="center">
  <img src="https://raw.githubusercontent.com/kisahtegar/kisahcode/master/overview/preview-1.png"/>
</p> -->

## About Us
<p align="left">

- 💻 All of my projects are available at [github.com/kisahtegar](https://github.com/kisahtegar)
- 📫 How to reach me **code.kisahtegar@gmail.com**
- 📄 Know about my experiences [kisahcode.web.app](https://kisahcode.web.app)

</p>