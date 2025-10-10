#!/usr/bin/env bash

# Path to your main borg backup script
BACKUP_SCRIPT="./borgbackup.sh"

# List of project folders to back up (relative to ~/code) add more as needed
PROJECTS=(
    "test"
	"code_gen"
)

# Loop through each project and call the backup script
for project in "${PROJECTS[@]}"; do
    echo "🔄 Backing up: $project"
    $BACKUP_SCRIPT backup "$project"
    echo "----------------------------------------"
done

echo "✅ All backups completed."
