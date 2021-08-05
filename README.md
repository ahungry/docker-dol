# dol

Dockerized version of the DOLSharp project.

Step one -  clone this repo.

Step two - download
https://github.com/Dawn-of-Light/DOLSharp/releases/download/1.9.7.3814/DOLServer_linux_net45_Debug.zip
and save into the releases directory.

Step three - type:

```
make
```

After the build, you should have a localhost:10300 connection, which
you can connect to using the DAOCPortal connect.exe program.

Connecting locally:

```
wine connect.exe game.dll localhost username password
```
