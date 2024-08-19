#!/bin/bash

# Loop over each directory that matches the pattern "rosbag2_*"
for dir in rosbag2_*; do
    if [ -d "$dir" ]; then
        # Change to the directory
        cd "$dir"

        # Find the .db3 file
        db3_file=$(ls *.db3)

        # Extract the filename without the extension
        base_name="${db3_file%.db3}"

        # Execute the mcap convert command with the output file named after the base name
        mcap convert "$db3_file" "$base_name.mcap"

        # Return to the parent directory
        cd ..
    fi
done

