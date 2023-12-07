
# harbor.cs.aalto.fi/aaltorse-public/git-annex
docker:
	docker build -t git-annex:latest .

git-annex.sif: docker
	apptainer build --force git-annex.sif docker-daemon://git-annex:latest
	./git-annex version > /dev/null

#git-annex.sif: git-annex.def
#	apptainer build --force git-annex.sif git-annex.def
