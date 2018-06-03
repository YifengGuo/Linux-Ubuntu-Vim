
# Shell Features
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
```
Aliases
    alias is a builtin command which can define shorthand for a longer command to save typing
    $ alias ll='ls -lG'
    $ ll
    total 436
    -rw-r--r--    1 smith    3584 Oct 11 14:59 file1
    
    
    aliases are stored in ~/.bash_aliases
    $ alias
    to see all the aliases on this system
```

```
Input/Output Redirection
    $ any command < inputFile   # Command reads from standard input can also read from a file as its input
    
    $ any command > outputFile  # Create / Overwrite output file
    
    $ any command >> outputFile # Append to output file (at the end of origin output file)
    
    $ any command 2> errorFile  # Write standard error to a file
    
    $ any command > outputFile 2> errorFile # Write output to a file and write error to another separately
    
    $ any command >& outputFile  # Write output and error to one file
    
    $ any command &> outputFile  # Write output and error to one file
```

```
Pipe
    | : redirect the standard output of one command to be the standard input of another command
    $ who | sort
    yifengguo pts/18       2018-06-02 00:45 (YifengGuo)
    yifengguo tty7         2018-06-02 00:44 (:0)

```

```
Process Substitution
    <():
    <(command) means wrap the output of the command as a named file
    eg.
        $ diff <(ls ~/*.jpg) <(ls ~/Documents/*.jpg)
```

```
Combining Commands
    command1 ; command2 ; command3  # invoke several commands in sequence on a single command line
    
    command1 && command2 && command3  # run commands in sequence but stops execution if any of them failed
    
    command1 || command2 || command3  # run commands in sequence and stop execution once any of them succeeds
```

```
Quoting
    whitespace normally is treated as separator of words. If word contains whitespace, use single or 
    double quoting to make shell know it is a unit
    signle quoting is to treat the contents literally
    double quoting can evaluate shell constructs like variables
    
    $ echo 'The variable HOME has value $HOME'
    The variable HOME has value $HOME
    
    $ echo "The variable HOME has value $HOME"
    The variable HOME has value /home/yifengguo
```

```
Escaping
    "\":
    If a charcter has special meaning to the shell but you want it used literally
    
    eg.
    $ ls D*   # As wildcard to match all "D" filenames
    
    $ ls D\*  # Literally treat as asterisk
    
    $ echo "I live in $HOME"
    I live in /home/yifengguo
    
    $ echo "I live in \$HOME"
    i live in $HOME
```

```
Command History
    Command                       Meaning
    $ history                     print command history
    $ history N                   print the most recent N commands in the history
    $ history -c                  delete your command histoty
    $ !!                          re-run previous command
    $ !N                          re-run command number N in your history
    $ ! -N                        re-run the command you typed N commands ago
```
```
Filename Completion
    use <tab> to make shell auto-complete the filename
    if several filenames match, the shell will beep. Immediately type tab again to see all matched ones
```
```
Shell Job Control
    job control:
        run commands in the background (multitasking behind the scenes)
        foreground (running as the active process at your shell prompt)
        
    job: shell's unit of work. When you run a command, your current shell tracks it as a job
         Jobs are at higher level than Linux processes, so Linux system knows nothing about jobs.
         
    Foreground Job: Running in a shell, occupying the shell prompt so you cannot run another command
    
    Background Job: Running in a shell, but NOT occupying the shell prompt, so you can run another 
                    command in the same shell
                    
    Suspend: To stop a foreground job temporarily
    
    Resume: To cause a suspended job to start running in the foreground again


    Command                       Meaning
    $ jobs                        List your jobs
    
    $ &                           Run a job in the background
        eg: 
        $ vim test.txt &
        [1] 17245
        $ jobs
        [1]+  Stopped                 vim test.txt
        # left most integer is job number. + means default job affected by the fg commands
        # - means affected by bg commands
    
    $ ^Z(ctrl+Z)                  Suspend the current foreground job
    
    $ fg                          Unsuspend a job: bring it into the foreground
        fg [%jobnumbr]
        $ fg %1
        # vim return to fg
    
    $ bg                          Make a suspended job run in the background

```