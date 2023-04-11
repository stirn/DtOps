#!/bin/bash

dotnet publish -c Release -r linux-arm64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/linux-arm64/publish/DtClient binaries/linux-arm64
dotnet publish -c Release -r linux-x64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/linux-x64/publish/DtClient binaries/linux-x64
dotnet publish -c Release -r osx-arm64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/osx-arm64/publish/DtClient binaries/osx-arm64
dotnet publish -c Release -r osx-x64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/osx-x64/publish/DtClient binaries/osx-x64
dotnet publish -c Release -r win-arm64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/win-arm64/publish/DtClient.exe binaries/win-arm64
dotnet publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true /p:PublishTrimmed=true && \
    cp bin/Release/net7.0/win-x64/publish/DtClient.exe binaries/win-x64
