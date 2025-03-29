## MARKITDOWN & git submodule handling

**Markitdown** is a tool to convert any type (or at least most of the types) of file to markdown: https://github.com/microsoft/markitdown?tab=readme-ov-file

We use it to change specifications into markdown files that can then be subjected to changes tracking.

Here, we use it as external tool, thus, making it an submodule inside our project (this enables staying in track with changes with that repo, without embedding it into our own repo)

Creating a submodule, and pulling the changes, is something done occasionally (that is only when major changes in version occur).
It's done manually by running the manage_markitdown script:

- in bash console (you can use fore example git bash) run:
  ``./documentation/doc2md/manage/manage_markitdown_copy.sh https://github.com/microsoft/markitdown.git``



