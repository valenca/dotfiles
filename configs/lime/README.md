# Installation:

This is a very rough version and is not distribution ready, so follow these instructions to work on your machine:

This repository presumes the directory ~/.lime, but can be called from anywhere in your machine if the following
instructions are met:

1. Install the python3 jira module

1. Add `source lime-completion.zsh` to your zshrc or `source lime-completion.bash` to your bash_profile

1. Add a link in your path to `~/.lime/lime` with the name `lime`, otherwise the zsh completion won't work.

1. Add your JIRA credentials to your `pass` store under feedzai/jira. Connecting to JIRA may require logging in the browser and solving the captcha.

# Usage:

Lime is intended to be a local mockup of a JIRA board for a quicker use for the purpose of **L**ogging t**ime**. It has the following commands:

1. `lime sprint` Looks up all the tasks assigned to the user in ongoing sprints to find which sprint has the most tasks assigned to them. Adds all the user-assigned AND unassigned tasks to the local task pool.
1. `lime add ISSUE-123` Adds a single task to your task pool, from where you can start it using tab-completion. Receives a JIRA key followed by a local description of the issue. If none is given, lime looks up the description in JIRA. Issues started by `NULL-[0-9]+` are ignored and meant to be used for personal tasks and time keeping.
1. `lime remove ISSUE-123` Removes a single task from the task pool to clean it up from the auto-completion.
1. `lime start ISSUE-123` Starts counting time in this task by entering a log. No two tasks can be done at once, so starting another task will stop the previous one.
1. `lime stop` Stops the current task, and prompts the user for commenting on the work done. Comments will be added to the work_log on submission.
1. `lime reset` Resets the current work log without submitting it. All removed lines are added to a long-living list, for future auditing and debug.
1. `lime clear` Clears the entire task pool.
1. `lime submit` Submits all the work logs to jira.
1. `lime show` Shows useful information about the various lists.
1. `lime status` Shows a summarized log with information like the currently working task and the total hours to be logged.
