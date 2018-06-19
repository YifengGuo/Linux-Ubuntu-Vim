# File Locations

```
find    Locate files in a directory hierarchy
xargs   Process a list of located files (and much more)
locate  Create an index of files, and search the index for string
which   Locate executables in your search path (command)
type    Locate executables in your search path (bash built-in)
whereis Locate executables, documentation, and source files

For finding files:
	find:        brute-force program that slogs file by file through directory hierarchy 
	             to locate target
	locate:      much faster than find, searching through a prebuilt index that you 
	             generate as needed
	             
	           
For finding programs:
	which:  (a command program usually in /usr/bin/which)
	        \
	         ->     check all directories in your shell search path 
	type:   /  (type is a built-in bash cmd, so it is faster but only available on bash shell)
```

### Search File on Linux

```
find
find [directories] [expression]
The find command searchesd one or more directories (and their subdirectories recursively) for files matching certain criteria.

examples:
	# find and print file called "myfile"
	$ find . -type f -name myfile -print
	
	# print filenames beggining with "myfile". (wildcard escape)
	# because we want myfile* as parameter for -name instead of anything starting with 
	# myfile
	$ find . -type f -name myfile\* -print
	
	# print all directories name
	$ find . -type d -print
	

Useful options:
	-name pattern    \     The name(-name), pathname(-path), or symbolic link target(-
	-path pattern    --->  lname) of the file must match given shell pattern like *,? and 
	-lname pattern   /     []. (YOU MUST ESCAPE THE WILDCARDS, SO THEY ARE IGNORED BY THE
	                       SHELL AND PASSED LITERALLY TO FIND). Paths are relative to the 
	                       directory tree being searched
	
	-type t                locate only files of type t: 
                           -type f     :     files
                           -type d     :     directories
                           -type l     :     symbolic link
                           -type b     :     block devices
                           -type c     :     character devices
                           -type p     :     named pipes
                           -type s     :     sockets
                            
	-atime N      \    File was last accessed(-atime), last modified(-mtime) or had status
	-ctime N     --->  change(-ctime) exactly N*24 hours ago. Use +N for "greater than N",
	-mtime N      /    or -N for "less than N"
	$ find . -type f -atime 0     # find all the modified within 24 hours 
	./FileLocations.md
	
	-empty                 File has zero size, and is a regular file or directory
	
	-user username    \    File is owned by the given username or group name
	-group groupname  /
	
	-print                 Simply print path to the file, relative to the search directory
	
	-print0                Like -print, but instead of separating each line of output with
	                       a new line character "\n", use a null (ASCII 0) character. Use 
	                       when piping the output of find to another program, and your 
	                       list of filenames may contain space characters. Of course, the 
	                       receiving program must be capable of reading and parsing thses
	                       null-separated lines (e.g xargs -0)
	
	-ls                    Perform ls on the found files
	$ find . -type f -atime 0 -ls
	8594028179        8 -rw-r--r--    1 guoyifeng        staff                2789 Jun 18 02:11 ./FileLocations.md
	8593973901       16 -rw-r--r--    1 guoyifeng        staff                4470 Jun 15 13:31 ./FileProperties.md
```



```
xargs
xargs [options] [command]
	It reads line of text from standard input, turns them into commands and executes them.
	
	Example:
	
	$ cat test_xargs.txt
    test_commands/test_dir1/1.txt
    test_commands/test_dir1/2.txt
    test_commands/test_dir2/22.txt
    test_commands/test_dir3/33.txt

	$ cat test_xargs.txt | xargs ls -lh
	-rw-r--r--  1 guoyifeng  staff     0B Jun 18 02:36 test_commands/test_dir1/1.txt
	-rw-r--r--  1 guoyifeng  staff     0B Jun 18 02:36 test_commands/test_dir1/2.txt
	-rw-r--r--  1 guoyifeng  staff     0B Jun 18 02:36 test_commands/test_dir2/22.txt
	-rw-r--r--  1 guoyifeng  staff     0B Jun 18 02:36 test_commands/test_dir3/33.txt
    
    Similarly:
    $ cat test_xargs.txt | xargs less     # read files in the text one page each time
    $ cat test_xargs.txt | xargs rm -f    # remove all the files listed in the text
    
    Each of these pipelines reads the list of files from test_commands/ and produces and runs new Linux commands based on the list. The power begins when the input list does NOT come from a file, but from another command writing to the standard output. In particular, the find command, which prints a list of files on standard output, makes it a great partner with xargs.
    
    # find all the files which contains word meat
    $ find . -type f -print | xargs grep -l meat 
    ./test_dir3/33.txt
   
    If any of the files located by find contains whitespace in its name, this  will confuse grep. Say filename is my file, then the command of grep will be translated as 
    $ grep -l meat my file
    which will try to match meat in two files instead of "my file"
    So to avoid this problem, use "-print0" instead of -print, which separates lines with ASCII null character instead of new line character, combined with "xargs -0", which expects ASCII null character
    $ find . -type f -print0 | xargs -0 grep -l meat
    
    xargs vs backquotes
    
    $ cat file_list | xargs rm -f
    $ rm -f 'cat file_list'
    $ rm -f $(cat file_list)
    These 3 commands do the same job but latter two command '' and $ has length limit
```



```
locate
locate [options]
    The locate command, with its partner updatedb, creates an
    index (database) of file locations that is quickly searchable. If
    you plan to search for many files over time in a directory hier‐
    archy that doesn’t change much, locate is a good choice. For
    locating a single file or performing more complex processing of
    found files, use find.
    Some distros automatically index the entire filesystem on a reg‐
    ular basis (e.g., once a day), so you can simply run locate and
    it will work. But if you ever need to create an index yourself of
    a directory and all its subdirectories (say, storing it in /tmp/
    myindex), run:
    $ updatedb -l0 -U directory -o /tmp/myindex   (lower L follwing by a zero)
    
    locate has an interesting, optional security feature. You can
    create an index that, when searched, will display only files that
    the user is permitted to see. So if the superuser created an index
    of a protected directory, a nonsuperuser could search it but not
    see the protected files. This is done by omitting the -l0 option
    to updatedb and running it as root:
    $ sudo updatedb -U directory -o /tmp/myindex
    
    updatedb options:
    -u                    Create index from the root directory downward.
    -U directory          Create index from directory downward.
    -l (0|1)              Turn security off (0) or on (1). The default is 1.
    -e directories        Exclude one or more directories from the index. Separate
                          their paths by commas.
    -o outfile            Write the index to file outfile.
    
    locate options:
    -d index              Indicate which index to use (in our example, /tmp/myindex).
    -i                    Case-insensitive search.
    -r regexp             Search for files matching the given regular expression.
```



### Search Program on Linux

```
which
which locates executable file in the shell's search path

$ which who
/usr/bin/who

$ which which
/usr/bin/which

If several programs in your search path have the same name
(e.g., /usr/bin/who and /usr/local/bin/who), which reports only
the first.
```



```
type
type [options] commands
type, like which, locates an executable file in the shell’s search path

$ type grep who
rep is an alias for grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}
who is /usr/bin/who

$ type which type rm if
which is a shell builtin
type is a shell builtin
rm is /bin/rm
if is a reserved word

As a built-in shell command, type is faster than which; however, it’s available only in certain shells such as bash
```

```
whereis
whereis [options] files
whereis attempts to locate the given files by searching a hardcoded list of directories.
It can find executubles, documentation, and source code. However it is not recommended to use whereis for its list of directories might not include the ones you need.

$ whereis vim
/usr/bin/vim

```

