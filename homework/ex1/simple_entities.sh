#!/bin/bash

# extract capitalized words, count them, reformat, save to file: 
cat alice_tok_de.txt | grep -E '^[A-Z][a-z]+' | sort | uniq -c | sort -nr | sed 's/^ *\([0-9]*\) \(.*\)$/\2\t\1/' | tr [:upper:] [:lower:] | sort > ent_freqs.txt

# reformat to get one sentence per line, 
# get rid of the bracketed numbers: [ xx ] (e.g. [1] before 'Erstes Kapitel'),
# keep all but the first words of sentences, reformat again to one word per line, 
# extract capitalized words, count them, keep the top 50, 
# and then only those that are not in the stopwords file, 
# finally match the lines to the lines of the word frequency file and sort by frequency
# and write the output to a file (OPTIONAL)
cat alice_tok_de.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n/g' | \
sed -E "s/\[ ?[0-9]+ ?\] //" | \
cut -d' ' -f2- | tr ' ' '\n' | \
grep -E '^[A-Z][a-z]+' | sort | uniq -c | sort -nr | head -50 | \
sed 's/^[ 0-9]*//' | sort | tr [:upper:] [:lower:] | comm -13 stopwords_de.txt - | \
join - ent_freqs.txt | sort -k2 -nr #> \
# result_german.txt