---
title: "HPCC via RStudio and GitHub"
author: "Wendy Leuenberger"
date: "2024-03-24"
output: 
  html_document:
    keep_md: true
---

This document is a guide to using MSU's HPCC. I access the HPCC via the Terminal in RStudio, and I move files from my computer to the HPCC using GitHub. I used the website [https://happygitwithr.com/](https://happygitwithr.com/) to set up this system. I reference pages of that guide for instructions or additional reading. This method takes a decent amount of setting up but is convenient once in place. 

Alex Wright and Erin Zylstra contributed to the sections about using the HPCC.

# Video Tutorial 

I presented this information and a live tutorial during the Spring 2023 IBIO 831 course. That video can be found here: [https://mediaspace.msu.edu/media/video1322048503/1_a56e12su](https://mediaspace.msu.edu/media/video1322048503/1_a56e12su)

# Software and Account Requirements

## RStudio

You need RStudio and R installed on your computer. 

RStudio: [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/). 

R: [https://cran.r-project.org/bin/windows/base/](https://cran.r-project.org/bin/windows/base/)

Additional reading on versions: [https://happygitwithr.com/install-r-rstudio.html](https://happygitwithr.com/install-r-rstudio.html)

## Git

### GitHub Account

You need a GitHub account for this method. You can make one here: [https://github.com/](https://github.com/). Here's some additional reading on making an account: [https://happygitwithr.com/github-acct.html](https://happygitwithr.com/github-acct.html)

You will need to know your username, password, and the email associated with your account for later steps.

### GitBash

Make sure that RStudio is running GitBash when it opens the Terminal. To do so, click Tools -> Global Options -> Terminal -> New terminals open with GitBash. If it doesn't say GitBash, change the drop down menu so that it does. It GitBash is not an option, you'll need to download Git. Here's reading on how to install Git for different operating systems: [https://happygitwithr.com/install-git.html](https://happygitwithr.com/install-git.html)

*Note:* these are the instructions for Windows. If you use a Mac, then the New Terminals open with Bash rather than GitBash. 

### Check installation

Go to the Terminal in RStudio. It's one of the tabs next to the Console. (Or use key command Shift+Alt+M) Type `which git` to make sure Git is installed. 

## HPCC set up

### Account

You need an account for the HPCC. A PI can request one. Instructions are here: [https://icer.msu.edu/users/getting-started](https://icer.msu.edu/users/getting-started)

### Sign-in

Make sure you can log in. Go to the Terminal window in RStudio. Type `ssh -XY MSUNetID@hpcc.msu.edu` and press enter. (Example: I type `ssh -XY leuenbe9@hpcc.msu.edu`)

Type your password and press enter. Sometimes it makes you do it twice.

If it doesn't work, contact ICER to see why

### Map the drive

This method works best if the HPCC drive is mapped to your computer. Follow the instructions here to do so. If it doesn't work or you get weird results, contact ICER. 

Samba mapping: [https://docs.icer.msu.edu/Mapping_HPC_drives_with_Samba/](https://docs.icer.msu.edu/Mapping_HPC_drives_with_Samba/). 

SSHFS mapping (Not recommended on Windows):  [https://docs.icer.msu.edu/Mapping_HPC_drives_with_SSHFS/](https://docs.icer.msu.edu/Mapping_HPC_drives_with_SSHFS/)

# GitHub and RStudio

## Git configuration

Introduce yourself to Git using your GitHub user name and the email used for your GitHub account (may or may not be your MSU one). Use the Terminal in RStudio or the R package `usethis` to do so.

Using the Terminal: 

`git config --global user.name 'Jane Doe'`

`git config --global user.email 'jane@example.com'`

`git config --global --list`

Using `usethis`:

`## install if needed (do this exactly once):`

`## install.packages("usethis")`

`library(usethis)`

`use_git_config(user.name = "Jane Doe", user.email = "jane@example.org")`

For further reading: [https://happygitwithr.com/hello-git.html](https://happygitwithr.com/hello-git.html). If you want GitHub to use 'main' instead of 'master' for the branch names, here are two ways to do that (only do one):

- Via command line: `git config --global init.defaultBranch main`
- Via R (usethis package): `usethis::git_default_branch_configure()`

## Personal Access Tokens

Personal Access Tokens (PAT) are the way that GitHub authenticates your computer's identity. You need one for each computer that you work from. I use https tokens, though there are also ssh tokens. Read here and the following chapter if you want more information (There's a ton of information on this step): [https://happygitwithr.com/https-pat.html](https://happygitwithr.com/https-pat.html)

### Create token

`usethis::create_github_token()` This line of code will open GitHub and begin the process of generating a token. You will need your password. The default settings that open up for the token have been fine by me so far. I usually name the token 'MSU laptop 9/22' or something similar to designate which computer it's for. They're easy enough to create that I leave the default 30 day expiration date, but you can change it if you wish. Click `Generate token`. Copy the string of numbers and characters that comes up. It'll be something like `ghp_LettersNumbersHere231`. This is the token. 

### Save token

Install the `gitcreds` package if necessary (`install.packages('gitcreds')`). Run `gitcreds::gitcreds_set()`. Follow the prompts. If this is your first token, I think it just asks you to enter the token. Paste the token when prompted. If you already have an active token, select 2 when prompted to replace the token, and enter the new token

# GitHub Repository

There are some good chapters on testing out repositories on the web guide. I'm going to skip them so that this set-up is more streamlined. We may have to revisit them if we run into any trouble. Here's the chapters in question: [https://happygitwithr.com/push-pull-github.html](https://happygitwithr.com/push-pull-github.html) and [https://happygitwithr.com/rstudio-git-github.html](https://happygitwithr.com/rstudio-git-github.html)

## Create a repo

We're going to create a new repository for a project. This is the easiest way to set it up. Here's the detailed reading: [https://happygitwithr.com/new-github-first.html](https://happygitwithr.com/new-github-first.html).

There are also instructions for existing projects, either with GitHub first [https://happygitwithr.com/existing-github-first.html](https://happygitwithr.com/existing-github-first.html) or last [https://happygitwithr.com/existing-github-last.html](https://happygitwithr.com/existing-github-last.html)

Go to your GitHub page. Click `New` next to your repositories, or on your profile, navigate to Repositories and then click `New`. Give your repo a name ('testrepo'). All other defaults are fine to start. You can add a description and a readme file if you want. The readme files are needed for the Zipkin lab and they can help keep things organized, but they're not required. If you work with proprietary data, you need to make sure the repo is set to private. I usually set my repos to private unless they're complete and ready to be shared. Once you're done with the settings, click `Create repository`. 

Click `Code` on the repo page. Copy the https URL (example: `https://github.com/wleuenberger/test-repo.git`)

# Link GitHub and RStudio

## Create RStudio project based on GitHub

There are many different ways to do this. I create RStudio projects for each of my Repos. I create one using the RStudio GUI. Click File -> New Project -> Version Control -> Git. Enter the https URL for the repo. Click Browse to choose where to save the repository and R project file. I have a folder on OneDrive for GitHub projects. I also have some in other folders for research. As long as you can find it again, it's fine. Click Create Project.

Additonal approaches and information is in the same chapter as creating repos: [https://happygitwithr.com/new-github-first.html](https://happygitwithr.com/new-github-first.html)

## GitHub via RStudio terminal

I find the command line really helpful for the RStudio workflow. There's only a couple of commands that are needed. There is also a Git GUI built into RStudio if you prefer that approach.

In your R project that is linked to your GitHub repository, navigate to the Terminal (separate tab next to the Console, or Alt+Shift+M). Type `git status`. The output will show you tracked files (ones that have been uploaded to Git in a previous version but have changes) and untracked files (not on GitHub yet). Files uploaded to GitHub and haven't been changed don't show up. This output is a helpful summary to see what files might need attention. I usually do this first. 

Before you start making any changes, type `git pull`. I've found that it's helpful to do that first as a habit to prevent any merge problems if someone else on a shared repo uploaded something, or if you have files on the HPCC that got changed. 

Add a file to the folder on your computer that is linked to your repo. I created an R code file called `AddMe.R`

Go back to your Terminal in RStudio. Type `git status`. You can now see your new file in the Untracked files section. Type `git add AddMe.R` (or whatever you called your file). Type `git status`. Now `AddMe.R` is in the section of Changes to be committed. You've told GitHub that you want this file, but it's not ready yet. All changes to your repos have to be committed and then pushed to get them on the repo. 

Type `git commit -m "Add my first file to GitHub"`. Commits are kinda like a save point. These can be incremental points and updates. For example, if I get one new piece of code working, I'll commit it with a note of what part got updated. You have to commit before you can upload. Type `git status` and you can see that your local branch is ahead of your GitHub repo by one commit. 

To upload, type `git push`. This will upload the file to GitHub. You can see online that it's now present. Type `git status`. Your local computer is now up to date with the main GitHub. 

If you make a change from another source (the HPCC, or if a collaborator makes a change), then you'll want to pull those changes with `git pull`. 

These are pretty much all the functions I do with GitHub. There is more reading online [https://happygitwithr.com/git-commands.html](https://happygitwithr.com/git-commands.html), as well as other chapters about how Git/GitHub work.

# Three Terminals

All of these pieces result in being able to do everything from the Terminal in RStudio. You can open multiple terminals. Once you've navigated to the Terminal, there's a dropdown menu right under the word 'Terminal' that is probably labeled 'Terminal 1'. Use the 'New Terminal' option to open two additional Terminal windows.

Terminal 1 saves and uploads files, Terminal 3 downloads files, and Terminal 2 is where you run the files on the HPCC. 

Terminal 1 is where you save and upload files to your repository. This Terminal's working directory should be your GitHub Repository. This on should already be in the correct place if you're working from an RStudio project that's linked to your GitHub. You can rename this Terminal if you want. Mine is labeled 'Laptop'.

Terminal 2 is your HPCC account. This is where you run your code. I label this one 'HPCC'. On this terminal, log into your HPCC account with the `ssh -XY MSUNetID@hpcc.msu.edu` and your password. To do work on the HPCC, you need to navigate to a development node (ex. `dev-intel14`). There are multiple. It doesn't matter which one you use. I always use one with low current usage. Type `ssh dev-intel14` (or whichever `dev-intel` you want) to enter the node.

Terminal 3 is your mapped HPCC drive. This is where you download your files from your repository. I have this one labeled 'Y Drive'. If you are off campus/not wired in, you need to be remotely connected to the BIG-IP Edge Client. You also need to be logged into your HPCC account. Find your mapped drive in your files and click on it. You may need to enter your password again. Then go to your third terminal Type `cd /y` (or whatever letter you picked) to set your mapped drive as the working directory for this terminal.  This terminal window can be a bit slower than your personal computer. 

## Get GitHub Repo on the mapped drive

The repo needs to be on your mapped drive/HPCC account. You can copy and paste it into your mapped drive. Or you can add it using the `git clone` command. Type `git clone` and the https URL for that repo (ex `git clone https://github.com/wleuenberger/test-repo.git`). Check that it's working via the `git status` command.

# Implementing this method and using the HPCC

## Navigate to your repository

Make sure that you are in your repository on all three terminals. Use the `cd` command to do. Just `cd` will put you at the base of your file structure (i.e. the `c/` drive). `cd ..` will move you up one folder. `ls` shows you the contents of your current working directory. `cd test-repo/` would let me enter the test-repo repository if that were a folder in my current working directory. `cd GitHub/test-repo/` would enter the GitHub folder and then the test-repo Repository within the GitHub folder. `cd y/` would put me on the Y drive while `cd c/` would put me on the C drive. If `cd y/` (or whatever letter you used for your mapped drive) doesn't work, make sure you are logged into the HPCC, the BIG-IP Edge Client if necessary (if on WiFi), and can open the Y drive in your finder window. 

## Push and pull

I do all of my changes from my computer itself. I regularly commit my changes and push whenever I want to move files to the HPCC. Navigate to the mapped drive terminal and pull those changes. Then switch to the HPCC and submit the jobs using the sbatch files (see Lab-Resources GitHub) or otherwise use the files on the HPCC. You then add, commit, and push any model output from the HPCC back to your computer.

## Necessary files

### R code

If you are using R, do not set a working directory in your code. Your working directory can be set in the `.sb` file or can be the directory that you submit the job from. 

Make sure that you save any output from your code. You can save R objects as `.RData`. Here's an example of saving the `Out` object to the `Output` folder as `Out.RData`

`save(list = Out, file = file.path('Output', 'Out.RData')))`

### Data and models

Any data you use in your R code must be on the HPCC. It can be in your working directory or in a subfolder. The file path must be given when uploading it if it's not in the working directory. Any `.stan` text files or other files that are referenced must also be available

### `.sb` file 

The sbatch file contains information needed to submit a job. Here is an example for a model run with Stan. You will need to adapt, and some programs (JAGS) require different settings. If you are running code on the development node and not submitting a job, you don't need this file.

`#!/bin/bash --login`

`# how long? Can specify up to 7 days in hours`\
`#SBATCH --time=168:00:00`

`# how much memory?`\
`#SBATCH --mem=20G`

`# specify nodes needed.`\
`#SBATCH --ntasks=1`\

`# specify CPUs (or cores per task)`\
`# Match this to your number of chains`\
`#SBATCH --cpus-per-task=3`

`# email me`\
`#SBATCH --mail-type=FAIL,END`\
`#SBATCH --mail-user=leuenbe9@msu.edu`

`# change to current directory or specify file path`\
`cd $SLURM_SUBMIT_DIR`

`# export R_LIBS_USER=/mnt/home/leuenbe9/R_Lib/4.0.2-X11-20200622`

`# add necessary modules`\
`module purge`\
`module load GCC/11.2.0`\
`module load OpenMPI/4.1.1`\
`module load R/4.1.2`\
`R --no-environ`

`# run R commandline with the Rscript command`\
`Rscript Code/R/TryModel_ISM.R --vanilla`

`squeue -l $SLURM_JOB_ID`

`scontrol show job $SLURM_JOB_ID`

#### Specifications

It can be hard to know how long your models take or the amount of memory/CPUs that you need. If you've run your code at least once in the past week, you can check and see how much time, CPU, and memory that you actually used. The code is: `reportseff -u username` and it shows the percent of resources you used relative to what you requested in your sb file. 

For example, I type:

`reportseff -u leuenbe9`

### Line endings

#### .gitattributes

The HPCC requires LF line breaks to run. It cannot run with the standard Windows line breaks (CRLF). You can change each file through command line, but it's often easier to tell git to change it for you. To do so, create a text file call `.gitattributes`. Set a default, and then state which file types need to be converted. A * indicates any text file, `*.R` means that any file with the extension `.R` will be converted to LF line endings when uploaded to GitHub. It won't change the original file on your computer. You will need this `.gitattributes` file in every repository. 

Here's example text for the `.gitattributes` file:

`# Set the default behavior, in case people don't have core.autocrlf set.`\
`* text=auto`

`# Declare files that should always have LF line endings once uploaded`\
`# Customize for which types of files you need`\
`*.stan text eol=lf`\
`*.R text eol=lf`\
`*.sb text eol=lf`

Save this file in your repository. Then use `git add`, `git commit`, and `git push` to upload it to your GitHub. 

Here's additional information and ways to set it globally: [https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings](https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings)

To set it globally, type this in your terminal: `git config --global core.autocrlf false`. 

#### Manually changing

From your working directory, type `file *`. This command will provide details on each file. You may see `with CRLF line terminators` on some files. If you do, type `dos2unix filename.extension` for each file. You can do more than one at once `dos2unix filename1.extension filename2.extension`. 

# Running code

## Development node

If you want to test or troubleshoot, you can run an R on a development node. (`dev-intel14`, `dev-intel16`, `dev-intel18`, accessed by `ssh` when first logging onto the HPCC) Purge modules and then load the ones you need:

`module purge`\
`module load GCC/11.2.0`\
`module load OpenMPI/4.1.1`\
`module load R/4.1.2`

Then you can either enter R by typing `R` (type `q()` to quit), or by running an entire file by typing `Rscript FileName.R`

## Installing additional R packages

Use the above code to load and open R. You can install packages in the same way that you install packages on your local computer (`install.packages("PackageName")`). You can also install packages underdevelopment from GitHub using the devtools code (e.g.: `devtools::install_github("doserjef/spAbundance")`), but install a regular CRAN package first to make sure your directory is set up for it. 

## Submit batch job

From your working directory, type `sbatch FileName.sb` This will submit the job. 

To check on your job, type `sq`. It will show as PENDING or RUNNING. If it ran into errors or finished, it will no longer show up. 

### .out file

Once your job is running, a `SLURM-#######.out` file will be created. Don't open it until the job is done. It will contain the output from R and your code, and will have some error messages if the job fails. 

# Common errors

## Packages not loaded

Not all R packages or R versions are available on the HPCC. If something you need isn't available, you can download it yourself, or contact ICER via Teams or making a ticket. Include the R version you want to use and the package names. They're pretty fast about getting packages loaded.

# Contact ICER if needed
  1) Office Hours: Monday/Thursday 1-2 PM on Teams (maybe also in person?). These can be really helpful and ICER can help you create/manage your workflows and speed up your code.
  2) User Manual/Wiki: [wiki.hpcc.msu.edu](wiki.hpcc.msu.edu) (see especially the sections labeled: Job Scheduling by SLURM and Job Management by SLURM)
  3) More information about running R and JAGS: [https://wiki.hpcc.msu.edu/display/ITH/R+-+CentOS+7](https://wiki.hpcc.msu.edu/display/ITH/R+-+CentOS+7)
