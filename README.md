# 🔥 FIRE - Emergency Git Script

Based on the famous "In case of fire: git commit, git push, leave building" meme, this script helps you quickly commit and push all your work across multiple git repositories when you need to evacuate quickly!

## 🚨 What it does

When you run `fire`, the script will:
1. Scan all directories in your configured path for git repositories
2. For each repository with uncommitted changes:
   - Create a random emergency branch (e.g., `fire_emergency_20231201_143022_a1b2c3d4`)
   - Add all changes (`git add .`)
   - Commit with message "🔥 FIRE TRIGGERED - Emergency commit at [timestamp]"
   - Push the emergency branch to remote (if configured)
3. Process all repositories **in parallel** for maximum speed ⚡

## 📦 Installation

### 🚀 One-Line Install (Recommended)
Install directly from GitHub with a single command:
```bash
curl -sSL https://raw.githubusercontent.com/uurtech/in-case-of-fire/master/install.sh | bash
```

*Or using wget:*
```bash
wget -qO- https://raw.githubusercontent.com/uurtech/in-case-of-fire/master/install.sh | bash
```

### Local Install
If you've already cloned the repository:
```bash
./install.sh
```

### Manual Install
```bash
# Make the script executable
chmod +x fire

# Copy to a directory in your PATH
sudo cp fire /usr/local/bin/fire

# Verify installation
fire --help
```

## 🎯 Usage

### First Time Setup
On first run, `fire` will ask you to specify the path to monitor:
```bash
fire
# Will prompt: "Which path should I monitor for git repositories?"
# Example: /Users/yourname/projects
```

### Emergency Use
```bash
fire
```

### Reconfigure Path
```bash
fire --setup
```

### Help
```bash
fire --help
```

## ⚙️ Configuration

The script stores its configuration in `~/.fire_config`. You can manually edit this file or use `fire --setup` to reconfigure.

## 🔒 Safety Features

- **Non-destructive**: Creates new branches instead of committing to current branch
- **Parallel processing**: Handles multiple repositories simultaneously
- **Error handling**: Continues processing other repos even if one fails
- **Validation**: Checks for git repositories and uncommitted changes
- **Fallback**: If branch creation fails, commits to current branch
- **Graceful degradation**: Works even without remote repositories

## 📋 Requirements

- Bash shell
- Git installed and configured
- Write access to target directories
- `openssl` (for random branch names) - falls back to `date` if not available

## 🎨 Example Output

```
🔥 FIRE EMERGENCY PROTOCOL ACTIVATED 🔥

ℹ️  Scanning for git repositories in: /Users/yourname/projects
ℹ️  Found 3 git repositories

ℹ️  Processing repositories in parallel...
ℹ️  Processing repository: my-website
ℹ️  Processing repository: cool-app
ℹ️  Processing repository: secret-project
ℹ️  Creating emergency branch: fire_emergency_20231201_143022_a1b2c3d4 in my-website
ℹ️  Creating emergency branch: fire_emergency_20231201_143022_b2c3d4e5 in cool-app
ℹ️  No changes to commit in secret-project
✅ Emergency backup completed for my-website -> fire_emergency_20231201_143022_a1b2c3d4
✅ Emergency backup completed for cool-app -> fire_emergency_20231201_143022_b2c3d4e5

🔥 FIRE EMERGENCY PROTOCOL ACTIVATED 🔥
✅ 🚨 FIRE EMERGENCY PROTOCOL COMPLETED! 🚨
ℹ️  All repositories have been processed. You can now safely leave the building! 🏃‍♂️💨
```

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this emergency tool!

## ⚠️ Disclaimer

IT THIS MESS UP ON YOUR CODE OR ANYTHING I WILL NOT GIVE A DAMN ABOUT IT... THIS IS AN OPENSOURCE FUN SCRIPT NOT YOU BACKUP PLAN!!!! 
**Remember**: In case of fire, git commit, git push, leave building! 🔥🏃‍♂️💨 
