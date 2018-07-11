# File Text Manipulation

```
grep           Find lines in a file that match a regular expression.
cut            Extract columns from a file.
paste          Append columns.
tr             Translate characters into other characters.
expand, \
         ->    Convert between tabs and spaces.
unexpand/     
sort           Sort lines of text by various criteria.
uniq           Locate identical lines in a file.
tee            Copy a file and print it on standard output, simultaneously.
```



```
grep
grep [options] pattern [files]
	 given one or more files, print all lines in those files that match 
     a particular regular expression pattern.
     
     example:
     $ grep pancakes test_grep.txt
     My very eager mother just served us nine pancakes.
     
     # use regular expression to find line which ends with '!'
     $ grep '\!$' test_grep.txt
     The quick brown fox jumped over the lazy dogs!
     
     -L Print only the names of files that do not contain matching lines.
     -c Print only a count of matching lines.
     -n In front of each line of matching output, print its original line number.
     -b In front of each line of matching output, print the byte o set of the line in the  
        input file.
     -i Case-insensitive match.
     -w Match only complete words (i.e., words that match the
        entire regular expression).
     
```



```
egrep       extended grep
egrep [options] pattern [files]

uses a different (“extended”) language for regular expressions. It’s the same as grep -E.

egrep:
    .                   any single character
    [...]               match any single character in the list
    [^...]              match any single character NOT in the list
    (...)               grouping
    \|   |              or
    ^                   beginning of a line
    $                   end of a line
    \<                  beginning of a word
    \>                  end of a word
    *                   0 or more repetitions of a regular expression
    \+   +              1 or more repetitions of a regular expression
    \?   ?              0 or 1 occurrence of a regular expression
    \{n\}  {n}          exactly n repetitions of a regular expression
    \{n,\}  {n,}        n or more repetitions of a regular expression
    \{n, m \}  {n, m}   Between n and m(inclusive) repetitions of a regular expression, 
                        n < m.
```



```
cut
cut -(b|c|f)range [options] [files]

-b byte offset
-c character offset

The cut command extracts columns of text from files. A “column” is defined by character offsets (e.g., the nineteenth char‐ acter of each line):
$ cut -c19 myfile
or by byte offsets (which are different from characters if your language has multibyte characters):
$ cut -b19 myfile
```



```
paste
The paste command is the opposite of cut: it treats several files
as vertical columns and combines them on standard output:
$ cat letters 
A
B
C
$ cat numbers 
1
2
3
4
5
$ paste numbers letters 
1 A
2 B
3 C
4
5
```



```
tr  (translate)
tr [options] charset1 [charset2]

translations of one set of characters into another
example:
    # translate all lower letters to upper cases
    cat file | tr 'a-z' 'A-Z'
    
    # convert all the vowels into asterisks
    cat file | tr aeiouAEIOU '*'
    
    # delete all vowels
    cat file | tr -d aeiouAEIOU
    
    

```



```
sort
sort [options] [files]

The sort command prints lines of text in alphabetical order, or sorted by some other rule you specify. All provided files are concatenated, and the result is sorted and printed.

-f          Case-insensitive sorting

-n          Sort numerically (i.e., 9 comes before 10) instead of

            alphabetically (10 comes before 9 because it begins with '1')
-g          Sort numerically by scientific notation
            (7.4e3 means “7.4 times ten to the third power,” or 7400)
            
-u          Unique sort: ignore duplicate lines.

-b          Ignore leading whitespace in lines.



```



```
uniq
uniq [options] [files]

The uniq command operates on consecutive, duplicate lines of
text. For example, if you have a file my letter2:
    $ cat letters2 
    a
    b
    b
    c 
    b
then uniq would detect and process (in whatever way you spec‐ ify) the two consecutive b’s, but not the third b:
    $ uniq letters2 
    a
    b
    c
    b
$ sort letters2 | uniq 
a
b
c 
In this case, only a single b remains because all three were made adjacent by sort, then collapsed to one by uniq. Also, you can count duplicate lines instead of eliminating them: which could be applied in word count
→ sort letters2 | uniq -c 
1 a
3 b 
1 c

-c           Count adjacent duplicate lines.
```



```
tee 
tee [options] files
Like the cat command, the tee command copies standard input to standard output unaltered. Simultaneously, however, it also copies that same standard input to one or more files. tee is most often found in the middle of pipelines, writing some intermediate data to a file while also passing it to the next com‐ mand in the pipeline:

$ who | tee original_who | sort
barrett   pts/1 Sep 22 21:15
byrnes    pts/0 Sep 15 13:51
silver    :0    Sep 23 20:44
silver    pts/2 Sep 22 21:18

This command line produces the sorted output of who on screen, but also writes the original, unsorted output of who to the file original_who, and then passes along that same output to the rest of the pipe‐ line (sort), producing sorted output on screen.

-a         Append instead of overwriting  les.
```

