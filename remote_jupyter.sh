JUPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
jupyter lab >$JUPDIR/jupout 2>$JUPDIR/juperr &
echo "$!"
