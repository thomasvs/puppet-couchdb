NAME=couchdb

test: $(NAME)
	puppet apply --modulepath=`pwd`/$(NAME) --noop manifests/init.pp

# FIXME: document then remove the no-documentation-check
check:
	puppet-lint --with-filename --fail-on-warnings --no-documentation-check manifests/*.pp

# do an ugly symlink so we can rely on the name being known
$(NAME):
	ln -sf . $(NAME)
