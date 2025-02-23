#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/vyxal/vyxal"
TOOL_NAME="vyxal3"
TOOL_TEST="vyxal3 --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi


sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' |
		grep '^3\.' # Only list v3.x.x releases
}

list_all_versions() {
	list_github_tags
}


download_release() {
	local version filename url
	version="$1"
	filename="$2"
	url="$GH_REPO/releases/download/v${version}/vyxal-${version}.jar"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
                # Step 1: Install Java (fun)
                curl -s "https://get.sdkman.io" | bash
                source "$HOME/runner/.sdkman/bin/sdkman-init.sh"
                sdk install java 21-open

                # Step 2: Install Vyxal 3
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		cd "$install_path"

		echo '#!/bin/bash
java -jar "$(dirname "$0")/vyxal3.jar" "$@"' > vyxal3 && chmod +x vyxal3

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
