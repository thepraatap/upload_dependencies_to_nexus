#!/bin/sh
read -p 'Enter dir path: ' directory

# search for top level package.json
find_first_package_json () {
   results=$(find $1 -maxdepth 1 -name package.json)
   # if not found, search deeper
   if [ -z "$results" ]; then
      for e in $1/*/; do
         echo "Searching $e"
         find_first_package_json $e
      done
   # if found, upload to npm
   else
      npmpath=$(dirname ${results})
      echo "Found $npmpath"
      echo "Uploading $npmpath"
      npm publish $npmpath -g
   fi
}

for d in "$directory"/*; do
        find_first_package_json $d
	#npm publish $file -g
	sleep 3
	
done
