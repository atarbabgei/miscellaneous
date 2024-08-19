
# Convert DB3 to MCAP

This script converts `.db3` files within directories into `.mcap` files with the same name as the original `.db3` files.

## Prerequisites

Before using the script, ensure that you have the `mcap` command-line tool installed. You can download the latest binary from the [MCAP GitHub Releases page](https://github.com/foxglove/mcap/releases).

## How to Use

1. **Download the Script**  
   Download `convert_db3_to_mcap.sh` and place it in the parent directory that contains the directories you want to convert.

   For example, your directory structure should look like this:

   ```
   /my_dir/
   ├── convert_db3_to_mcap.sh
   ├── rosbag2_2024_06_14-11_09_26
   ├── rosbag2_2024_06_14-11_13_17
   └── rosbag2_2024_06_14-11_17_04
   ```

2. **Make the Script Executable**  
   Before running the script, you need to make it executable. Open a terminal, navigate to the directory where the script is located, and run the following command:

   ```bash
   chmod +x convert_db3_to_mcap.sh
   ```

3. **Run the Script**  
   To convert all the `.db3` files in the subdirectories, run the script by executing:

   ```bash
   ./convert_db3_to_mcap.sh
   ```

   The script will process each directory, converting the `.db3` files into `.mcap` files. The output `.mcap` files will be named the same as the original `.db3` files, but with the `.mcap` extension.

## Example

If you have a directory structure like this:

```
/my_dir/
├── rosbag2_2024_06_14-11_09_26
│   └── example.db3
├── rosbag2_2024_06_14-11_13_17
│   └── sample.db3
└── rosbag2_2024_06_14-11_17_04
    └── test.db3
```

After running the script, you will get the following output:

```
/my_dir/
├── rosbag2_2024_06_14-11_09_26
│   ├── rosbag2_2024_06_14-11_09_26.db3
│   └── rosbag2_2024_06_14-11_09_26.mcap
├── rosbag2_2024_06_14-11_13_17
│   ├── rosbag2_2024_06_14-11_13_17.db3
│   └── rosbag2_2024_06_14-11_13_17.mcap
└── rosbag2_2024_06_14-11_17_04
    ├── rosbag2_2024_06_14-11_17_04.db3
    └── rosbag2_2024_06_14-11_17_04.mcap
```

## Notes

- The script processes only directories that match the pattern `rosbag2_*`.
- Each `.db3` file in these directories will be converted to an `.mcap` file with the same base name.