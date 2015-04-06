#!/bin/bash
# Thanks to Andreas Gohr (http://www.splitbrain.org/) for the initial work 
# https://github.com/splitbrain/paper-backup/
OUT_DIR=~/scan
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

# check if there is blank pages
echo 'checking for blank pages...'
for f in ./*.pnm; do
    unpaper --size "a4" --overwrite "$f" `echo "$f" | sed 's/scan/scan_unpaper/g'`
    #need to rename and delete original since newer versions of unpaper can't use same file name
    rm -f "$f"
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
