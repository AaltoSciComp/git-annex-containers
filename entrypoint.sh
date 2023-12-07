#!/bin/sh
# This would usually not be needed.  You can `git-annex shell` just as well.
if [ "$APPTAINER_NAME" = "git-annex-shell" ] ; then
    git-annex-shell "$@"
else
    git-annex "$@"
fi
