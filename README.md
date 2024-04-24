# GitHub Commit Statistics Fetcher

This repository contains a Bash script to fetch and display commit statistics for a public GitHub repository.

## How it Works
The script, `fetch_and_format_stats.sh`, takes two required arguments:

- `repository_owner`: The username or organization that owns the repository.
- `repository_name`: The name of the repository.

### Optional Argument:
- `-t`, `--top=<number>`: This flag allows you to specify the number of top contributors to display (defaults to 3).

The script retrieves commit data from the GitHub API and displays the following information:

- **Total Commits**: The total number of commits in the repository.
- **Commits by Author**: A list of authors and their commit counts, sorted by the highest number of commits first.
- **Top N Contributors**: (Optional) Information about the top N contributors, including their username and commit count. (N is specified by the `-t` flag)

The script uses ANSI escape codes to format the output with colors for better readability.

## Running the Script
1. Make sure you have Bash installed on your system.
2. Clone this repository or download the script `fetch_and_format_stats.sh`.
3. Open a terminal and navigate to the directory containing the script.
4. Run the script with the required arguments:

```bash
./fetch_and_format_stats.sh <repository_owner> <repository_name> [options]
```
# Script Usage Examples

## Basic Usage
```bash
./fetch_and_format_stats.sh facebook react
```

This will display the commit statistics for the Facebook's react repository.

