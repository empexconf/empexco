require 'fileutils'

GH_PAGES_BRANCH = "gh-pages"
DEV_BRANCH   = "master"
PROJECT_ROOT = `git rev-parse --show-toplevel`.strip
BUILD_DIR    = File.join(PROJECT_ROOT, "build")
GH_PAGES_REF = File.join(BUILD_DIR, ".git/refs/remotes/origin/#{GH_PAGES_BRANCH}")

directory BUILD_DIR

file GH_PAGES_REF => BUILD_DIR do
  repo_url = nil

  cd PROJECT_ROOT do
    repo_url = `git config --get remote.origin.url`.strip
  end

  cd BUILD_DIR do
    sh "git init"
    sh "git remote add origin #{repo_url}"
    sh "git fetch origin"

    if `git branch -r` =~ /#{GH_PAGES_BRANCH}/
      sh "git checkout #{GH_PAGES_BRANCH}"
    else
      sh "git checkout --orphan #{GH_PAGES_BRANCH}"
      sh "touch index.html"
      sh "git add ."
      sh "git commit -m 'initial #{GH_PAGES_BRANCH} commit'"
      sh "git push origin #{GH_PAGES_BRANCH}"
    end
  end
end

# Alias to something meaningful
task :prepare_git_remote_in_build_dir => GH_PAGES_REF

# Fetch upstream changes on gh-pages branch
task :sync do
  cd BUILD_DIR do
    sh "git fetch origin"
    sh "git reset --hard origin/#{GH_PAGES_BRANCH}"
  end
end

# Prevent accidental publishing before committing changes
task :not_dirty do
  puts "***#{ENV['ALLOW_DIRTY']}***"
  unless ENV['ALLOW_DIRTY']
    fail "Directory not clean" if /nothing to commit/ !~ `git status`
  end
end

desc "Compile all files into the build directory"
task :build do
  cd PROJECT_ROOT do
    sh "bundle exec middleman build --clean"
  end
end

desc "Push to #{DEV_BRANCH}"
task :push_to_dev_branch do
  status = `git status`

  if /On branch #{DEV_BRANCH}/ !~ status
    warn "Please publish from the #{DEV_BRANCH} branch"
  end

  if /nothing to commit/ !~ status
    warn "Please commit or stash changes first"
  end

  if /Your branch is ahead/ =~ status
    sh "git push origin #{DEV_BRANCH}"
  end
end

desc "Build and publish to Github Pages"
task :publish => [:push_to_dev_branch, :not_dirty, :prepare_git_remote_in_build_dir, :sync, :build] do
  message = nil

  cd PROJECT_ROOT do
    head = `git log --pretty="%h" -n1`.strip
    message = "Site updated to #{head}"
  end

  cd BUILD_DIR do
    sh 'git add --all'
    if /nothing to commit/ =~ `git status`
      puts "No changes to commit."
    else
      sh "git commit -m \"#{message}\""
    end
    sh "git push origin #{GH_PAGES_BRANCH}"
  end
end
