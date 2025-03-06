#!/bin/bash

# Function to calculate the number of files and total size
calculate_files_and_size() {
    local folder_path=$1
    if [ -d "$folder_path" ]; then
        file_count=$(find "$folder_path" -type f | wc -l)
        total_size=$(du -sh "$folder_path" | cut -f1)
        echo "$folder_path: $file_count files, $total_size"
    else
        echo "$folder_path: Folder not found. Skipping."
    fi
}

# Function to copy the folders to the new destination
copy_folders() {
    local src_folder=$1
    local dest_folder=$2
    if [ -d "$src_folder" ]; then
        # Create the destination folder if it doesn't exist
        mkdir -p "$dest_folder"
        # Copy the contents
        cp -r "$src_folder"/* "$dest_folder/"
        echo "Copied contents of $src_folder to $dest_folder."
    else
        echo "$src_folder does not exist. Skipping."
    fi
}

# Path to the QtCore dynamic library (passed as first argument)
qtcore_prefix="$1" 

# Name for the destination folder (passed as second argument)
destination_root="$2"

# Check if both parameters are provided
if [ -z "$qtcore_prefix" ] || [ -z "$destination_root" ]; then
    echo "Usage: $0 <path_to_qtcore_directory> <destination_folder_name>"
    exit 1
fi

# Create the root folder where all subfolders will be copied
destination_folder="$destination_root"
mkdir -p "$destination_folder"

# Subfolders and their relative paths
subfolders=("QtCore" "doc" "include" "lib" "libexec" "bin" "plugins" "imports" "qml" "" "" "translations" "examples" "tests" "")

# Subfolder names for echo output
subfolder_names=("Prefix" "Documentation" "Headers" "Libraries" "LibraryExecutables" "Binaries" "Plugins" "Imports" "Qml2Imports" "ArchData" "Data" "Translations" "Examples" "Tests" "Settings")

# Loop through each subfolder and calculate file count and size
for i in ${!subfolders[@]}; do
    subfolder="${subfolders[$i]}"
    folder_name="${subfolder_names[$i]}"

    if [ -z "$subfolder" ]; then
        folder_path="$qtcore_prefix/$folder_name"
	# folder_path="$qtcore_prefix/$subfolder"
    else
        folder_path="$qtcore_prefix/$subfolder"
    fi

    # Copy the folder and contents to the new destination folder
    # new_folder="$destination_folder/$folder_name"

    new_folder="$destination_folder/$subfolder"
    copy_folders "$folder_path" "$new_folder"

    # Calculate file count and size for the copied folder
    calculate_files_and_size "$new_folder"
done

