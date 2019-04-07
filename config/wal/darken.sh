
infile="$1"
inname=`convert $infile -format "%t" info:`
convert $infile -thumbnail 1366x768! -write ${inname}1.jpg \
-fill black -colorize 20% ${inname}2.jpg
