#!/bin/bash

## BESCHREIBEN

comm -3 <( cat data/alice_tok_de.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '[A-ZÄÖÜ][a-zäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)' | sort | tr [:upper:] [:lower:] ) \
 <( cat data/alice_tok_de.txt | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '[A-zÄÖÜäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)' | tr [:upper:] [:lower:] | sort) \
 | uniq -c | sort -nr | head -15

