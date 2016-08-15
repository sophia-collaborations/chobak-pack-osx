
# This script is invoked by the "initial-install.pl" script
# after assuring that all the prerequisite software is installed
# on the system.


# First, we create the bin directory - and make sure that for now
# it is on our execution path.
mkdir -p ~/bin
PATH="${HOME}/bin:${PATH}"
export PATH

# Now we create and enter the place where we will store the
# -chobakwrap- packages themselves.
mkdir -p ~/etc/chobakwrap
cd ~/etc/chobakwrap || exit 4

# Now we install the main -chobakwrap- package:
rm -rf x
mv chobakwrap x
git clone https://github.com/sophia-collaborations/chobakwrap.git || ( rm -rf chobakwrap )
( cd chobakwrap || mv x chobakwrap )
rm -rf x
( cd chobakwrap && sh install.sh )

# Now we install -languamunity-
rm -rf x
mv languamunity x
git clone https://github.com/LanguagMunity/languamunity.git || ( rm -rf languamunity )
( cd languamunity || mv x languamunity )
rm -rf x
( cd languamunity && sh install.sh )




