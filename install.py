import json
import os
import shutil

old_versions = os.path.expanduser("~/old_versions")
default_filename = "map.json"
source_root = os.path.dirname(os.path.abspath(__file__))
target_root = os.path.expanduser("~")

def read_mapping(filename: str):
    with open(filename) as stream:
       return json.load(stream) 

full_mapping = read_mapping(default_filename)

def deal_with_existing_file_if_exists(file_path):
    full_path = os.path.abspath(file_path)
    if os.path.islink(file_path):
        print(f"Removing existing symlink {file_path}")
        os.unlink(file_path)
    elif os.path.isfile(file_path):
        shutil.move(file_path, old_versions)
        print(f"Moving {file_path} to old_versions")


def create_full_path_if_not_exists(file_path):
    # Get the absolute path
    full_path = os.path.abspath(file_path)
    
    # Get the directory name
    directory = os.path.dirname(full_path)
    
    # Check if the file exists
    if not os.path.exists(full_path):
        # Create the directory if it doesn't exist
        if not os.path.exists(directory):
            os.makedirs(directory)
        print(f"Full path created: {full_path}")
    
    return full_path

create_full_path_if_not_exists(old_versions)

for directory_mapping in full_mapping:
    target_directory = ""
    source_directory = ""
    if directory_mapping["directory"] == "HOME":
        target_directory = target_root
        source_directory = source_root
    else:
        target_directory = os.path.join(target_root, directory_mapping["directory"])
        source_directory = os.path.join(source_root, directory_mapping["directory"])

    for link in directory_mapping["links"]:
        source = os.path.join(source_directory, link["file"])
        target = os.path.join(target_directory, link["link"])
        print(source + " -> " + target)
        create_full_path_if_not_exists(target)
        deal_with_existing_file_if_exists(target)

        os.symlink(source, os.path.expanduser(target))
