FROM mcr.microsoft.com/dotnet/framework/runtime:4.7.2

COPY bin/ /opt/qt-installer/bin
COPY templates/ /opt/qt-installer/templates

ENTRYPOINT ["/opt/qt-installer/bin/install-qt.ps1"]