# cat alice_tok_de.txt | grep -vxf stopwords_de.txt - | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '[A-ZÄÖÜ][a-zäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)' | tr [:upper:] [:lower:] | sort | uniq | sort

echo "Dieser Test sollte etwas Hergeben" | grep -oE '[A-Za-zÄÖÜäöüß]+'

#  [A-ZÄÖÜ][a-zäöüß]+
# echo "Dieser Test sollte etwas Hergeben" | grep -oE '[A-ZÄÖÜ][a-zäöüß]+ ([A-ZÄÖÜ][a-zäöüß]+)'

# cat alice_tok_de.txt | grep -vxf stopwords_de.txt - | sed 's/^$/@/' | tr '\n' ' ' | sed 's/ @ /\n\n/g' | cut -d' ' -f2- | grep -oE '[A-zÄÖÜäöüß]+ [A-ZÄÖÜ][a-zäöüß]+' | tr [:upper:] [:lower:] | sort | uniq -c | sort -nr