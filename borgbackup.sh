#!/usr/bin/env bash

# This script allows for management of BorbBackup to backup the `code` directory located in the user's home directory `~/code`.

# Setup the Code directory if it doesn't exist
if [ ! -d "$HOME/code" ]; then
	mkdir -p "$HOME/code"
	echo "Created directory: $HOME/code"
fi

# Set your Borg repository path (can be local or remote)
BORG_REPO=~/borg-repo
BACKUP_SOURCE=~/code
BORG_PASSPHRASE="default1234"  # Optional: use environment variable for security

# Export passphrase for non-interactive use
export BORG_PASSPHRASE

# Initialize the Borg repository if it doesn't exist
if [ ! -d "$BORG_REPO" ]; then
	echo "Initializing Borg repository at $BORG_REPO..."
	borg init --encryption=repokey "$BORG_REPO"
fi

# Function to initialize a backup of a specific subfolder
init_backup() {
    local project_name=$1
    local timestamp=$(date +%Y-%m-%d_%H-%M)
    local source_path="$BACKUP_SOURCE/$project_name"

    if [ ! -d "$source_path" ]; then
        echo "❌ Project folder '$source_path' does not exist."
        return 1
    fi

    echo "📦 Backing up '$project_name'..."
    borg create --verbose --stats \
        "$BORG_REPO::$project_name-$timestamp" \
        "$source_path"

    echo "✅ Backup completed: $project_name-$timestamp"
}

# Function to list available backups for a project
list_backups() {
    local project_name=$1
    borg list "$BORG_REPO" | grep "^$project_name-" | awk '{print $1}'
}

# Function to restore a backup by project name and date
restore_backup() {
    local project_name=$1
    local backup_date=$2
    local archive_name="$project_name-$backup_date"
    local restore_path="$BACKUP_SOURCE/$project_name-restored-$backup_date"

    echo "🔍 Looking for archive: $archive_name"
    if ! borg list "$BORG_REPO" | grep -q "^$archive_name"; then
        echo "❌ Archive '$archive_name' not found."
        return 1
    fi

    echo "♻️ Restoring '$archive_name' to '$restore_path'..."
    borg extract --verbose "$BORG_REPO::$archive_name" 

    echo "✅ Restore completed to: $restore_path"
}

# Help message
usage() {
    echo "Usage:"
    echo "  $0 backup <project_name>         # Create a backup"
    echo "  $0 restore <project_name> <date> # Restore a backup by date (format: YYYY-MM-DD_HH-MM)"
    echo "  $0 list <project_name>           # List backups for a project"
}

# Main logic
case "$1" in
    backup)
        init_backup "$2"
        ;;
    restore)
        restore_backup "$2" "$3"
        ;;
    list)
        list_backups "$2"
        ;;
    *)
        usage
        ;;
esac
