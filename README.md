Latex & Julia docker container
=====

This container helps with compilation of latex sources without the need to install all latex packages on your system.

This repository is forked from blang's repository in order to add support for Julia and other packages needed for a CI setup.

Setup
-----
First, add your local user to docker group:
```bash
sudo usermod -aG docker YOURUSERNAME
```

build:
```bash
docker build -t jgoldfar/juliatex .

```

Usage:
-----

```bash
dockercmd.sh (to open a shell)

# Or better in one go (does not start container twice)
../dockercmd.sh /bin/sh -c "pdflatex example.tex && pdflatex example.tex"

# View
./example.pdf
```
Use `dockercmd.sh` to execute any command you like inside the container. `WORKDIRs` match, mounted to `/data` inside container.

Why should I use this container?
-----

- Easy setup
- `texlive-full` covers most of the available packages
