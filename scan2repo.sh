#!/bin/bash
OUT_DIR=~/scan
BASE="~/tmp"
cd $BASE
TMP_DIR=`mktemp -d`
FILE_NAME=scan_`date +%Y%m%d-%H%M%S`
LANGUAGE="eng" 				# the tesseract language - ensure you installed it

echo 'scanning...'
scanimage --resolution 300 \
	  --batch="$TMP_DIR/scan_%03d.pnm" \
          --format=pnm \
          --mode Gray \
          --source 'ADF Duplex' 
echo "Output saved in $TMP_DIR/scan*.pnm"

cd $TMP_DIR

# cut borders 
echo 'cutting borders...'
for i in scan_*.pnm; do
    mogrify -shave 50x5 "${i}"
done

# check if the page is blank
# http://philipp.knechtges.com/?p=190
echo 'checking for blank pages...'
for i in scan_*.pnm; do
    echo "${i}"
    histogram=`convert "${i}" -threshold 50% -format %c histogram:info:-`
    white=`echo "${histogram}" | grep "#FFFFFF" | sed -n 's/^ *\(.*\):.*$/\1/p'`
    black=`echo "${histogram}" | grep "#000000" | sed -n 's/^ *\(.*\):.*$/\1/p'`
    blank=`echo "scale=4; ${black}/${white} < 0.005" | bc`

    if [ ${blank} -eq "1" ]; then
        echo "${i} seems to be blank - removing it..."
        rm "${i}"
    fi
done

# apply text cleaning and convert to tif
echo 'cleaning pages...'
for i in scan_*.pnm; do
    echo "${i}"
    convert "${i}" -contrast-stretch 1% -level 29%,76% "${i}.tif"
done

# do OCR
echo 'doing OCR...'
for i in scan_*.pnm.tif; do
    echo "${i}"
    tesseract "$i" "$i" -l $LANGUAGE hocr
    hocr2pdf -i "$i" -s -o "$i.pdf" < "$i.html"
done

# create PDF
echo 'creating PDF...'
pdftk *.tif.pdf cat output "$FILE_NAME.pdf"

wput $FILE_NAME.pdf ftp://uid:pwd@scanner.domain:21/Alfresco/scans/

cp $FILE_NAME.pdf $OUT_DIR/
rm -rf $TMP_DIR
