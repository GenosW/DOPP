#!/bin/bash

cat data/alice_tok_de_original.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n/g' | \
sed -E "s/\[ ?[0-9]+ ?\] //" | \
cut -d' ' -f2- | tr ' ' '\n' | \
sed 's/^[ 0-9]*//' | comm -13 data/stopwords_de.txt - > data/alice_tok_de_.txt