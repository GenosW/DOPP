#!/bin/bash

# extract capitalized words, count them, reformat, save to file: 
cat data/alice_tok.txt | grep -E '^[A-Z][a-z]+' | sort | uniq -c | sort -nr | sed 's/^ *\([0-9]*\) \(.*\)$/\2\t\1/' | sort > data/ent_freqs.txt

# reformat to get one sentence per line, keep all but the first words of sentences, reformat again to one word per line, extract capitalized words, count them, keep the top 50, and then only those that are not in the stopwords file, finally match the lines to the lines of the word frequency file and sort by frequency
cat data/alice_tok.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n/g' | cut -d' ' -f2- | tr ' ' '\n' | grep -E '^[A-Z][a-z]+' | sort | uniq -c | sort -nr | head -50 | sed 's/^[ 0-9]*//' | sort | tr [:upper:] [:lower:] | comm -13 data/stopwords.txt - | sed 's/^./\u&/' | join - data/ent_freqs.txt | sort -k2 -nr