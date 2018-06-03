# Linux File System

#### File System Basics

```
/ root directory
path starting with / is absolute directory
```
```
. current working directory
.. parent directory
```

```
Users and Superusers
    HOME is a environment variable, also ~
    echo $HOME or ~ to see the current user
    superuser's name is root
```

```
Linux typically has tens of thousands of system directories.
    operating system files
    aplications
    documentation
    everything except personal user files (/home/$username)
```

```
/user/local/share/emacs
|   Scope  |Category|Application
```

```
/boot: Files for booting the system. This is where the kernal lives. /boot/vmlinuz or similar
```
#### File Protection

```
who has the permission:
    owner: the user who created the file can do anything on this file. But can be changed by superuser
    group: a group of users who have permissions to access the a file
    other (the world or all users)

what kind of permission is granted:
    three kinds of operations on the file or directory by owner, group and the world
        read
        write
        execute

ls -l ~/Downloads/YifengGuo.pdf     -l to check the ownership of a file
-rw-rw-r-- 1 yifengguo yifengguo 50623 Mar 12 19:53 YifengGuo.pdf

ls -ld ~/Downloads     -ld to check the ownership of a directory
drwxr-xr-x 10 yifengguo yifengguo 4096 Jun  2 18:34

Explanation on the ownership:
    -rwxr-x---
    position                meaning:
    1                       File type: - : file
                                       d : directory
                                       l : symbolic link (reference)
                                       p : named pipe
                                       c : character device
                                       b : block device

    2-4                     Read, write and execution permissions for the file's owner

    5-7                     Read, write and execution permissions for the file's group

    8-10                    Read, write and execution permissions for all other users
```

#### Shell Features
```
shell is somewhere to type the commands on Linux system (Linux's command line user interface)
```

```
$ who
yifengguo tty7         2018-06-02 00:44 (:0)
yifengguo pts/18       2018-06-02 00:45 (YifengGuo)

$ who | wc -l     (pipe to get the word count by line of the result of command who)
2
```
```
Shell VS Programs
When you run a command, it might invoke a Linux program or instead it might be a built-in command
use type to see the type of commands

$ type who
who is hashed (/usr/bin/who)  which means who is a Linux program

$ type cd
cd is a shell builtin
```
```
Wildcard
    $ ls a*
    the shell first expands a* into the filenames that begins with "a" in the current directory.
    * IMPORTANT *:
    	ls never knows you used a wildcard: it sees only the final list of filenames after the 
        shell expands the willcard
        This means every Linux command, regardless of its origin, works with wildcards and other 
        shell features.

    wildcard cannot match leading period(.) and the directory slash(/)
    for example 
    $ ls .pro*
    to match .profile
    $ ls /etc/*conf
    to match all filenames ending in conf in the /etc directory

Wildcard          Meaning
*                 Zero or more consecutive characters

?                 Any single character

[set]             Any single character in the given set, most commonly a sequence of characters,
                  like [aeiouAEIOU] for all vowels, or a range with a dash, like [A-Z] for all 
                  capital letters

[^set]            Any single character not in the given set, such as [^0-9] to mean any nondigit
[!set] = [^set]

{X, YY, ZZZ}      First match X, then YY, then ZZZ
```
```
Variable
    $ MYVAR=3    # to assign a variable
    $ echo MYVAR
    3

    The scope of variable, by default, is the shell which it is defined.
    So to make the variable and its value available to other programs your shell invokes, use export command:
    $ export MYVAR
    now MYVAR is called environment variable which is available to other programs in your shell's environment

    $ printenv
    get all the environment variables of this linux system
```

```
Search Path:
    Programs are scattered all over the Linux FileSystem. How does shell find the program you invoke via shell?
    Variable PATH is critical.
    
    $ who
    then shell locates command who by searching through Linux durectories in $PATH
    $ echo $PATH
    /usr/local/bin:/bin:/usr/bin
    and looks for who command in each of these directories. 
    If it finds (/usr/bin/who), then it runs the command.
    Otherwise, reports failure like bash: who: command not found
    
    Temporarily add directory into $PATH: only works on current shell
        $ PATH=$PATH:/usr/sbin
    
    Permanently add directory into $PATH:
        modify the PATH variable in the startup file: ~/.bashrc (or ~/.bash_profile) and then log out 
        and log in or simply $ source ~/.bashrc
```
