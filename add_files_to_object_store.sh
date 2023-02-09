#!/bin/bash
#curl -XPUT  "https://api.fastly.com/resources/stores/object/$OBJECTSTORE/keys/00000" \
#    -H "Fastly-Key: $FASTLYPERSONALTOKEN" -H "Accept: application/json" \
#    -d @./hibp_object_store/00000.txt

## Ths is needed to add each file to it's own text file.
#awk '{F=substr($0,1,5)".txt";print >> F;close(F)}' ~/Documents/mygit/compute-hibp-passwords-api/pwned-passwords-sha1-ordered-by-hash-v8.txt

# Testing
# curl https://hibp-api.edgecompute.app/range/00000


# Add files to ECP API
upload() {
  OBJECTSTORE=""
  for filename in $1*.txt; do
    OBJKEY=(`basename $filename | cut -c 1-5`)
    #echo "key to upload: " $OBJKEY
    #echo "filename to upload " "$filename"

    mv $filename processed/$filename

    curl -XPUT  "https://api.fastly.com/resources/stores/object/$OBJECTSTORE/keys/$OBJKEY" \
       -H "Fastly-Key: oL8fkUH5Bmthk_MdVfj-PiR6XP-QlY_a" \
       -H "Accept: application/json" \
       -H "if-generation-match:0"
       --data-binary "@processed/$filename"

  done
}

