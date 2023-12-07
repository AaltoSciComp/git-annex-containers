# Container definitions for git-annex

Containerized versions of git-annex, for use when installing git-annex
may be a bit more work than you'd like.  This is expected to be
especially useful on computer clusters, so we provide extra
documentation for that use case.



## Apptainer / Singularity

Download the latest:
```console
$ wget https://github.com/AaltoSciComp/git-annex-containers/releases/download/latest/git-annex.sif
```

Building from the docker image:
```console
$ apptainer build git-annex.sif docker://ghcr.io/aaltoscicomp/git-annex:latest
```

The Dockerfile is the primary build (and that is how the released
`git-annex.sif` is made).  An old singularity definition
file is included in case it is important for you:
```console
$ apptainer build git-annex.sif git-annex.def
```

Running:
```console
$ ./git-annex.sif [git-annex commands]
```

You can rename the `.sif` file to `git-annex` and put it in a
directory on `PATH`, and then it will function exactly like the
`annex` subcommand for your normal git installation: you can run `git
annex`.

For use as a remote over SSH, you need to set up **git-annex-shell**.
You can use `git-annex.sif shell` can be used, for
example: `git config remote.NAME.annex-shell "/path/to/git-annex.sif
shell"` Special cases that may occur:
* If your repo is not in the default bind-mounted filesystems ($TMP,
  $HOME), you need to bind mount it.  This can be used: `git config
  remote.NAME.annex-shell "apptainer run -B /scratch /path/to/git-annex.sif
  shell"`

On your own computer,this git-annex container can access your SSH
authentication (keys, ControlMaster sockets).  But there are some
special cases:
* To access your SSH agent, you need to bind the socket inside.  You
  can `export SINGULARITY_BIND=$SSH_AUTH_SOCK` or run `apptainer run
  -B $SSH_AUTH_SOCK git_annex.sif`

* git-annex sets up its own ControlMaster for mulitplexing.  If you
  already have one running, set `git config annex.sshcaching false` it
  can automatically re-user existing ssh ControlMaster from `/tmp`,
  which is bind-mounted by default.



## Docker

There's a Dockerfile here, but there may not be much use for it since
this is designed to be run in the Apptainer style as a local utility.
Docker is made mainly so that you can build Apptainer from docker by
pulling the image.

```console
$ docker pull ghcr.io/aaltoscicomp/git-annex:latest
```
