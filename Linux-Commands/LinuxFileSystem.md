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