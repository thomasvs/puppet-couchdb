NAME=couchdb

test: $(NAME)
	puppet apply --modulepath=`pwd`/$(NAME) --noop manifests/init.pp

# do an ugly symlink so we can rely on the name being known
$(NAME):
	ln -sf . $(NAME)
