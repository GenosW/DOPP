#!/bin/bash

cat data/alice_tok_de.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n/g' | \
sed -E "s/\[ ?[0-9]+ ?\] //" | \
cut -d' ' -f2- | tr ' ' '\n' | \
sed 's/^[ 0-9]*//' | comm -13 data/stopwords_de.txt - > data/alice_tok_de_cleaned.txt

# This doesn't work, need to generate the full list of 2 word tokens and somehow filter that by splitting the words, then filtering and rejoining smartly!

{ echo ' '; cat data/alice_tok_de_cleaned.txt; } > data/alice_tok_de_cleaned_shifted.txt