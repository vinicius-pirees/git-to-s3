docker run -d vgoncalves/git-to-s3 [git-option]


### Examples:

Run with http authentication

```
docker run --rm -it \
-e ACCESS_KEY=<aws_key> \
-e SECRET_KEY=<aws_secret> \
-e S3_PATH=s3://<bucket_name>/<path>/ \
-e GIT_REPO=https://github.company.com/org/repo.git \
-e GIT_USER=<git_user> \
-e GIT_PASSWORD=<git_password> \
vgoncalves/git-to-s3 git-http
```

Run with ssh authentication

```
docker run --rm -it \
-e ACCESS_KEY=<aws_key> \
-e SECRET_KEY=<aws_secret>  \
-e S3_PATH=s3://<bucket_name>/<path>/ \
-e GIT_REPO=git@github.company.com:org/repo.git \
-v $HOME/.ssh:/root/.ssh \
vgoncalves/git-to-s3 git-ssh
```
