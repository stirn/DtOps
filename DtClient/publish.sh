#!/bin/bash

dotnet publish -c Release -r linux-arm64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
dotnet publish -c Release -r linux-musl-arm64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r linux-x64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r linux-musl-x64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r osx-arm64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r osx-x64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r win-arm64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
#dotnet publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true #/p:PublishTrimmed=true
