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
	type:   /  (type is a built-in bash cmd, so is only available on bash shell)
```



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
```

