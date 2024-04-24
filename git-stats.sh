#!/bin/bash


fetch_and_format_stats() {
  local repo_owner="$1"
  local repo_name="$2"

 
  stats_json=$(curl -s "https://api.github.com/repos/$repo_owner/$repo_name/stats/contributors")

  # Check for API request failures
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to retrieve data from GitHub API."
    exit 1
  fi

 
  total_commits=$(echo "$stats_json" | jq '. | length')

  # Print formatted output header with color
  if [[ $total_commits -eq 0 ]]; then
    echo "No commits found in this repository."
  else
    echo -e "\e[1m\e[34mGitHub Commit Statistics for $repo_owner/$repo_name:\e[0m"  # Bold blue header
    echo "--------------------------------------------------"
    echo "Total Commits: $total_commits"
    echo ""
  fi

  # Parse JSON and calculate total commits
   total_commits=$(echo "$stats_json" | jq '. | length')

  # Print formatted output header with color (using ANSI escape codes)
  echo -e "\e[1m\e[34mGitHub Commit Statistics for $repo_owner/$repo_name:\e[0m"  # Bold blue header
  echo "--------------------------------------------------"
  echo "Total Commits: $total_commits"
  echo ""

  # Print author-wise statistics with color and sorting
  echo -e "\e[1m\e[32mCommits by Author:\e[0m"  # Bold green title
  echo "$stats_json" | jq '.[] | {author: .author?.login, commits: .total}' | sort -k2 -nr | awk '{printf "\t\e[33m%s\e[0m: %d commits\n", $1, $2}'  # Yellow author, normal commit count

  # **New Feature: Top Contributors (limited to top 3 by default)**
  top_contributors=$(echo "$stats_json" | jq '.[] | {author: .author?.login, commits: .total}' | sort -k2 -nr | head -n 3)
  echo -e "\n\e[1m\e[35mTop 3 Contributors:\e[0m"  # Bold magenta title
  echo "$top_contributors" | jq -r '.[] | "\t\(.author): \(.commits) commits"'  # Readable output with indentation

  echo -e "\e[0m"

}

if [[ $# -eq 0 || $# -gt 2 || "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <repository_owner> <repository_name> (options)"
  echo ""
  echo "Options:"
  echo "  -h, --help: Display this help message."
  echo "  -t, --top=<number>: Show top N contributors (default: 3)."
  exit 1
fi

# Extract arguments
repo_owner="$1"
repo_name="$2"

# Handle optional flag for top contributors (default 3)
top_count=3
while getopts ":t:" opt; do
  case $opt in
    t) top_count="$OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done


shift $((OPTIND-1))

fetch_and_format_stats "$repo_owner" "$repo_name" "$top_count"

