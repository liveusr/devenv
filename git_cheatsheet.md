# Git Cheatsheet

## Git Sparse Checkout (Download Specific Folders)

Use this method to pull down specific folders from massive repositories without downloading the entire project history or unwanted files.

#### 1. Clone the repository without downloading any project files
```bash
# --no-checkout: Initialize an empty working directory without unpacking files
# --depth 1: Truncate history and download only the latest commit
# --filter=blob:none: Skip fetching file contents until git-checkout

git clone --no-checkout --depth 1 --filter=blob:none <REPOSITORY_URL>
```

#### 2. Navigate into the repository directory
```bash
cd <REPO_NAME>
```

#### 3. Restrict the folder constraints strictly to your targets
```bash
# --no-cone: Match specified paths exactly, blocks default top-level files

git sparse-checkout set --no-cone <PATH_TO_FOLDER_1> <PATH_TO_FOLDER_2>
```

#### 4. Manually pull and unpack only the matched folder contents
```bash
git checkout
```

### Utility Commands

#### View currently active folder filters
```bash
git sparse-checkout list
```

#### Disable sparse checkout and restore full repository access
```bash
git sparse-checkout disable
```

[^ Back to Top](#git-cheatsheet)
