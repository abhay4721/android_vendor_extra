VENDOR_EXTRA_PATH=$(gettop)/vendor/extra
VENDOR_PATCHES_PATH="${VENDOR_EXTRA_PATH}/patches"


for project_name in $(cd "${VENDOR_PATCHES_PATH}" || exit; echo */); do
        project_path="$(tr _ / <<<"$project_name")"

        cd $(gettop)/"${project_path}" || exit
        echo "Applying patches for project: ${project_name} on ${HEAD_COMMIT}"
        if ! git am "${VENDOR_PATCHES_PATH}"/"${project_name}"/*.patch --no-gpg-sign; then
                echo "Failed to apply patches for project: ${project_name}. Aborting."
                git am --abort &> /dev/null
        fi

        cd $(gettop) || exit
done
