export EDITOR=nvim;
if ! command -v vim > /dev/null; then
  vim() {
    nvim $@
  }
fi

if ! command -v vi > /dev/null; then
  vi() {
    nvim $@
  }
fi
