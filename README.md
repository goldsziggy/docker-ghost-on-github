# Docker-Ghost-On-Github

This dockerfile will be used my server array to publish the local ghost site to Github Pages. This dockerfile essentially paraterizes the npm package `ghost-static-site-generator` which does the real heavy lifting.

## ARGS

| ARG              | Description                                                                   |
| ---------------- | ----------------------------------------------------------------------------- |
| GH_PAT           | Your github personal-access-token so the script can push commits to your repo |
| GH_REPO          | Your github repo that will contain the static site                            |
| REMOTE_URL       | The URL that the static site will be hosted from                              |
| GHOST_SERVER_URL | The URL of your local instance of GHOST                                       |
| GIT_NAME         | What name should the git-commit come from                                     |
| GIT_EMAIL        | what email the git commit should come from                                    |

## Sample build command

```shell
docker build --build-arg GH_PAT=abc123 --build-arg GH_REPO=github.com/goldsziggy/neighborlynook.git --build-arg GHOST_SERVER_URL="https://hidden.example.com" --build-arg GIT_EMAIL="matt@zygowicz.com" --build-arg GIT_NAME="Matthew Zygwoicz" -t ghost-on-git .
```

## Sample Run Command

The following command will be used to actually run the script and push the updates to your static site. At bare minimum this should be set to a daily cron.

```shell
docker run -it ghost-on-git
```
