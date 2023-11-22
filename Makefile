git-annex.sif: git-annex.def
	apptainer build --force git-annex.sif git-annex.def

docker:
	docker build -t harbor.cs.aalto.fi/aaltorse-public/git-annex .

