# SciRuby-Docker

Docker image for SciRuby users.
This docker image contains gem as follows:
* [nmatrix](https://github.com/SciRuby/nmatrix) (latest)
* [statsample](https://github.com/clbustos/statsample) (latest)
* pry + [iruby](https://github.com/minad/iruby) (latest)
* [nyaplot](https://github.com/domitry/nyaplot) (latest)
* [mikon](https://github.com/domitry/mikon) (latest)
* and other dependent libraries

## Usage

Run commands as follows in your shell

```
docker pull domitry/sciruby-docker
docker run -i -p 9999:9999 -v $PWD:/notebooks/mount domitry/sciruby-docker:latest
# and open localhost:9999 on your browser
```

## Links
* [sciruby.com](http://sciruby.com/)
* [Mailing list(Google groups)](https://groups.google.com/forum/#!forum/sciruby-dev)
