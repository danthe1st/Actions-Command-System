#!/bin/bash
# this script checks all bash scripts with spellcheck
set -e
sucess=0
regex='#!/bin/.*sh'
while read -r path; do
	if [ -f "$path" ]; then
		#head -n 1 "$path"
		if [[ "$path" == "*.sh" ]]||[[ "$(head -n 1 "$path"|tr -d '\0')" =~ $regex ]];then
			shellcheck "$path"||sucess=$?
		fi
	fi
done <<< "$( find . -not -path './.git/*' )"
exit $sucess
