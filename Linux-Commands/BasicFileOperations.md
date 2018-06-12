# Basic FIle Operations

```
ls: List files in a directory
    $ ls [options] [files]
    
    $ ls dir1 dir2 dir2
    $ ls file1 file2 file3
    
    $ ls -a # show hidden files
    
    $ ls -l # produces long listing
    -rw-rw-r-- 1 yifengguo yifengguo  80440 May  8 10:35 1stMapper.png

	$ ls -ld dir    # -d option lists the info about the directory itself
    
    $ ls -F   # decorate filenames with meaningful symbols. "/" for dir, "@" for symbolic links etc.

```
```
cp Copy a file
    cp [options] files (file | directory)
    
    $ cp file anotherFile  # copy a file
    
    $ cp file1 file2 file3 myDir  # copy multiple files to a directory
    
    $ cp -r dir1 dir2   # recursively copy a dir to another
    
    $ cp -f    # force copy. If a destination file exists, overwrite it unconditionally
```

```
mv Rename("move") a file
    mv [options] source target
    
    $ mv file1 file2  # rename file1 as file2
    
    $ mv file dir   # mv file to a directory
```
```
rm Delete("remove") a file
    rm [options] (files | directories)
    
    $ rm file
    $ rm -r dir
    
    $ rm -r -f dir # force remove dir ignoring any warnings or errors
```
```
ln Create links (alternative names) to a file
    A link is a reference tp another file, created by the 'ln' command. links give the same file multiple
    names, allowing it to live in two (or more) locations at once.
    
    symbolic link (symlink or soft link): another file by its path (like shortcut,  a pointer in c++)
    if delete original file, softlink cannot further work because it will point a non-existent path.
    # to create the soft link on a file
    $ ln -s myfile mysoftlink
    
    hard link is a hard copy or a image of the file. Even delete original file, hard link can also work.
    $ ln myfile hardlink
    
    # to check which file does link point to
    $ readlink examplelink
    
    $ ls -l examplelink
    
    $ readlink -f examplelink   # if current link points another link
```

```
Directory  Operations
    cd
    pwd
    basename  # print the final part of a file path
    dirname   # print a file path withput its final part
    
    
    mkdir    # create one or more directories
    mkdir [options] directories
    $ mkdir dir1 dir2 dir3
    
    # given a directory path (not just a simple directory name), create any necessary parent directories
    # automatically
    $ mkdir -p one/two/three
    
    rmdir     # remove an empty directory
    rm -r     # remove a nonempty directory and its contents
```

```
File Viewing
cmd [options] [files]
    cat    print file to standard output (concatenate)
    
    less   view text by one page at a time
    $ cmd1 | cmd2 | cmd3 | cmd4 | less
    
    nl     prepend line number in the beginning. like cat -n
    
    head   prints the first 10 lines of a file
    $ head file
    $ head file* | less    # previewing multiple files and show it by one page each time
```

```
tail
The tail command prints the last 10 lines of a file. 
$ nl myfile | tail # print the last 10 lines of a file and its linenumber

-f option causes tail to watch a file actively while another program is writing to it, 
displaying new lines as they are written. This is invaluable for watching a Linux log file
in active use as other programs write to it:
    $ tail -f /var/log/syslog
```

```
File Creation and Editing
nano
emacs    +  new_file
vim

$ touch new_file

$ echo anything > new_file
```
