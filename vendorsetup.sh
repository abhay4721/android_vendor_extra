PATCHES_PATH=${ANDROID_BUILD_TOP}/vendor/extra/patches

for project_name in $(cd "${PATCHES_PATH}" || exit; echo */); do
	project_path="$(tr _ / <<<"$project_name")"
	cd "${ANDROID_BUILD_TOP}" || exit
	cd "${project_path}" || exit
	echo "Applying patches for project: ${project_name} on ${HEAD_COMMIT}"
	if ! git am "${PATCHES_PATH}"/"${project_name}"/*.patch --no-gpg-sign; then
		echo "Failed to apply patches for project: ${project_name}. Aborting."
		git am --abort &> /dev/null
	fi

	cd "${ANDROID_BUILD_TOP}" || exit
done


