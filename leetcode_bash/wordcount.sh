# !/bin/sh
# tr -s '' '\n' to separate each word as one line, -s is to make multiple adjacent whitespaces as single one
# sort it to make duplicate words be adjacent
# uniq -c to count the frequency for unique word
# sort -r is to make resuly in descending order
# switch field 2 (count) and field 1 (word)
cat text_for_wordcount.txt | tr -s ' ' '\n' | sort | uniq -c | sort -r | awk '{print $2" "$1}'
