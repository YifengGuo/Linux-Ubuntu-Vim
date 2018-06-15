# File Properties
```
stat
    The state command lists important attributes of files or filesystems (-f option)
    $ stat myfile
    
    $ state -f myfile
```

```
du
du [options] [files|directories]
    The du (disk usage) command measures the disk space occupied by files or directories.
    By default, it measures the current directory and all its subdirectories, printing totals
    in blocks.
    $ du .
    
    $ du -b   # measure usage in bytes
    $ du -k   # measure usage in kilobytes
    $ du -m   #...............in megabytes
    $ du -h   # print in human-readable units
```
```
file
file [options] files
	The file command reports the type of a file. The output is an educated guess based on 
	the file content and other factors.
	$ file README.md
	README.md: c program text, ASCII text, with very long lines
	
	# show the type of destination file instead of this symbolic file
	$ file -L symbolic-link
	
```

```
touch
```

```
chown
chown [options] user_spec files
	The chown (change owner) command sets the ownership of files and directories.
	
    # change owner for files or dirs
	$ sudo chown yifengguo file1 file2 dir1 
	
	# set the owner and group of the file
	$ sudo chown yifengguo : users file 
```

```
chgrp
chgrp [options] group_spec files
	The chgrp command sets the group ownership of files and directories.
    The group_spec parameter could be group name or group ID
```

```
chmod
chmod [options] permissions files
	The chmod(change mode) command protects files and dirs from unauthorized users on the same system by setting access permissions. Typical permissions are read, write and execute, and they may be limited to the file owner, the file's group owner, and/or other users. 
	Three forms for parameter of chmod:
		1. --reference=file, to set the same permissions as another given file
		2. An octal number, up to four digits long, that specifies the file's absolute permissions in bits. The left-most digit is special attribute. The second, third, and fourth represent the file's owener, the file's group and all users' RWX permission respectively.
        3. One or more strings specifying absolute or relative permissions
        
        example:
        octal                 0       6      4      0
        binary:              000     110    100    000
        symbolic:            sst     rwx    rwx    rwx
                          special    user   group  others
                          attribute  (u)     (g)    (o)
                                      |______________|
                                           ALL
                                           (a)
       most common permissions:
       $ chmod 600 myfile               # private file for you
       $ chmod 644 myfile               # everyone can read, buy only you can write
       $ chomd 700 mydir                # private directory for you
       $ chmod 755 mydir                # everyone can read, but only you can write
       
       r for read, w for write, x for execute (for directories, this is permission to cd into the directory)
       
       $ chmod ug+rw file     # add read and write permission for the user and the group
```

```
umask
umask [options] [mask]
	The mask command sets or displays your default mode for creating files and directories -- whether they are readable, writable and/or executable by yourself, your group, and the world.
	$ umask
	0002
	$ umask -S
	u=rwx, g=rwx, o=rx
	
	A umask is a binary (base two) value, though it is commonly presented in octal(base eight). It defines your default protection mode by combining with the octal value 0666 for files and 0777 for directories, using the binary operation NOT AND. For example, the umask 0002 yields a default file mode of 0664:
	   0666 NOT AND 0002
	=  000110110110 NOT AND 000000000010
	=  000110110110 AND 1111111111101
	=  000110110100
	=  0   6  6  4
	
	   0666 NOT AND 0022
	=  000 110 110 110 NOT AND 000 000 010 010
	=  000 110 110 110 AND 111 111 101 101
	=  000 110 100 100
	=  0    6   2   2
	        u   g   o
	
	Similarly for dirs, 0002 NOT AND 0777 yields a default mode of 0775
	
	tips: 
	use mask 0022 to give yourself full privileges and all others read/execute privileges only
	$ umask 0022
	$ touch file1 && mkdir dir1
	$ ls -ldG file dir
	
	use mask 0002 to give yourself and your default group full previleges, and read/execute to others.
	
	user mask 0077 to give yourself full previleges with nothing for anyone else.
	 
```





