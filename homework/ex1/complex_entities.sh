#!/bin/bash

# The main idea is to generate a list of 2 word entities where both words start with capital letters.
# The program functions in 3 stages:
# First, the part in the first instance of `<( ... )` is executed, 
# then the second instance of `<( ... )` is executed.
# Finally, we obtain the final entity counts via grep.

# Part 1: Find 2 word entities
# Load the tokenized file and filter out lines that match exactly to a stopword via grep (unfortunately, this may not work properly as multiple instances of `das` remain...although they SHOULD be filtered out)
# then we proceed as before, reformating to one sentence per line and getting rid of the first word per sentence.
# `grep -oE '[A-ZÄÖÜ][a-zäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)'` filters out 2 word entities (i.e. 2 words with capitalized first letter in sequence) and prints only matching sequences (not the whole line/sentence) seperated by line breaks.
# The results are then brought to lower case, sorted and only unique appearances kept and sorted again to be sure.
# Part 2:
# Proceeds very similar to part.
# However, `grep -oE '[A-zÄÖÜäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)` now filters out every sequence where any word precedes a capitalized word (e.g. 'falsche Schildkröte' is counted as well as 'Falsche Schildkröte').
# These results are then counted to get the proper entity counts (similar to the simple entity frequencies).
# Part 3:
# The second list is then filtered for only those entities found in part 1 and the top 2 are printed.
# This has to be done since often only the first occurence of a 2 word entity (e.g. 'Falsche Schildkröte') is capitalized properly.
grep -f <( cat alice_tok_de.txt | grep -vxf stopwords_de.txt - | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '([A-ZÄÖÜ][a-zäöüß]+) ([A-ZÄÖÜ][a-zäöüß]+)' | tr [:upper:] [:lower:] | sort | uniq | sort ) <( cat alice_tok_de.txt | grep -vxf stopwords_de.txt - | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '[A-Za-zÄÖÜäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)' | tr [:upper:] [:lower:] | sort | uniq -c | sort -nr ) | head -n20

# grep command used twice:
# grep -vxf:
# -v, --invert-match
#   Selected lines are those not matching any of the specified patterns.
# -x, --line-regexp
#   Only input lines selected against an entire fixed string or regular expression are considered to be matching lines.
# -f file, --file=file
#   Read one or more newline separated patterns from file.  Empty pattern lines match every input line.  Newlines are not considered part of a pattern.  If file is empty, nothing is matched.