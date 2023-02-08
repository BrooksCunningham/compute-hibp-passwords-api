#!/bin/bash
#curl -XPUT  "https://api.fastly.com/resources/stores/object/u2w0y3zmack9wo3dckrc2d/keys/00000" \
#    -H "Fastly-Key: $FASTLYGMAILAPITOKEN" -H "Accept: application/json" \
#    -d @./hibp_object_store/00000.txt

# fastly objectstore insert --id=u2w0y3zmack9wo3dckrc2d -k=00001 --value="$(cat ./hibp_object_store/00001.txt)"

## Ths is needed to add each file to it's own text file.
#awk '{F=substr($0,1,5)".txt";print >> F;close(F)}' /Users/brookscunningham/Documents/mygit/compute-hibp-passwords-api/pwned-passwords-sha1-ordered-by-hash-v8.txt

# Testing
#http https://hibp-api.edgecompute.app/range?hash=00000 -p=bh

# for filename in hibp_object_store/*.txt ; do ; echo $filename ; done

# maybe split hibp data set into smaller files to parse in buffers
# split -b 1g pwned-passwords-sha1-ordered-by-hash-v8.txt segment


# For files in directory
# for filename in hibp_object_store/segment* ; do
#     awk '{F=substr($0,1,5)".txt";print >> F;close(F)}' filename
# done


# Add files to ECP API
    for filename in hibp_object_store/*.txt; do
        OBJKEY=(`basename $filename | cut -c 1-5`)
        echo "key to upload: " $OBJKEY
        echo "filename to upload " "$filename"
        curl -XPUT  "https://api.fastly.com/resources/stores/object/u2w0y3zmack9wo3dckrc2d/keys/$OBJKEY"     \
            -H "Fastly-Key: $FASTLYGMAILAPITOKEN" \
            -H "Accept: application/json"     \
            --data-binary "@$filename"
    done

