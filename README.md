# Container definitions for git-annex

Containerized versions of git-annex, for use when installing git-annex
may be a bit more work than you'd like.


## Apptainer / Singularity

Building from source:

```console
$ apptainer build git-annex.sif git-annex.def
```

Building from the docker image:
```console
$ apptainer build git-annex.sif docker://harbor.cs.aalto.fi/aaltorse/git-annex:latest
```

Running:

```console
$ ./git-annex.sif [git-annex commands]
```

For `git-annex shell` access, `git-annex.sif shell` can be used, for
example: `git config remote.NAME.annex-shell "/path/to/git-annex.sif
shell"` Special cases of `git-annex shell`:
* You may need to set `SINGULARITY_BIND=$SSH_AUTH_SOCK` to make
  your ssh agent work (with `git config annex.sshcaching false` it can
  automatically re-user existing ssh ControlMaster from `/tmp`).
* If your repo is not in the default bind-mounted filesystems ($TMP,
  $HOME), you need to bind mount it.  This can be used: `git config
  remote.NAME.annex-shell "apptainer run -B /scratch /path/to/git-annex.sif
  shell"`


## Docker

It's in the Dockerfile, but there may not be much need to use this.
Docker is made mainly so that you can build Apptainer from docker by
pulling the image.
