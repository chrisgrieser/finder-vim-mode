#!/bin/zsh
# ensure relevant files exist
if [[ ! -f "./.github/workflows/release.yml" ]]; then
	echo "/.github/workflows/release.yml does not exist yet"
	exit 1
fi

# Prompt for version number
nextVersion="$*"
echo -n "   next version: "
if [[ -z "$nextVersion" ]]; then
	read -r nextVersion
else
	echo "$nextVersion"
fi
echo ""

# update changelog
echo "- $(date +"%Y-%m-%d")	release $nextVersion" >./Changelog.md
git log --pretty=format:"- %ad%x09%s" --date=short | grep -Ev "minor$" | grep -Ev "patch$" | grep -Ev "typos?$" | grep -v "refactoring" | grep -v "Add files via upload" | grep -Ev "\tDelete" | grep -Ev "\tUpdate.*\.md" | sed -E "s/\t\+ /\t/g" >>./Changelog.md

# push the manifest and versions JSONs
git add -A
git commit -m "release $nextVersion"

git pull
git push

# trigger the release action
git tag "$nextVersion"
git push origin --tags
