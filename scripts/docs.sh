#!/bin/bash
# this script generates documentation for all scripts
set -e
regex='#!/bin/.*sh'
docPath="/tmp/docs/"
while read -r path; do
	if [ -f "$path" ]; then
		if [[ "$path" == "*.sh" ]]||[[ "$(head -n 1 "$path"|tr -d '\0')" =~ $regex ]];then
			echo "# $(echo "$path" | rev | cut -d '/' -f 1 | rev )" > "$docPath$path.md"
			while read -r line; do
				if [[ "$line" == \#\ * ]];then
					echo "$line"|cut -c3-
					echo
				else
					break
				fi
			done >> "$docPath$path.md" <<< "$(tail -n +2 < "$path")"
		fi
	else
		mkdir -p "$docPath$path"
	fi
done <<< "$( find . -not -path './.git/*' | tail -n +2 )"
