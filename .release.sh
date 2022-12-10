#!/usr/bin/env zsh

# CONFIG
ORIGIN="$HOME/.config/karabiner/assets/complex_modifications/finder-vim.yaml"

#───────────────────────────────────────────────────────────────────────────────

# ensure relevant files/clis exist
if [[ ! -f "./.github/workflows/release.yml" ]]; then
	echo "/.github/workflows/release.yml does not exist yet"
	exit 1
fi
if [[ ! -f "$ORIGIN" ]]; then
	echo "$(basename "$ORIGIN") does not exist."
	exit 1
fi
if ! command -v yq &>/dev/null; then
	echo "yq not installed."
	exit 1
fi

# Prompt for version number
nextVersion="$*"
currentVersion=$(grep -o -e "version: \[[0-9.]*\]" "$ORIGIN" | grep -o -e "[0-9.]*")
echo "current version: $currentVersion"
echo -n "   next version: "
if [[ -z "$nextVersion" ]]; then
	read -r nextVersion
else
	echo "$nextVersion"
fi
echo ""

# Bump version number in original finder-vim.yaml
sed -E -i '' "s/version: .*/version: [$nextVersion]/" "$ORIGIN"

# Copy file from personal repo
cp -vf "$ORIGIN" .

# Build
yq -o=json 'explode(.)' finder-vim.yaml >finder-vim.json

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
