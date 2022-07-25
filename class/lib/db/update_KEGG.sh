#!/bin/bash
#wget ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz
#gzip -d gene_info.gz
#cat gene_info | grep "^9606" | awk -F '\t' '{print $2"\t"$3;}' > geneSymWithID_9606.txt

#Whole API link
#http://www.kegg.jp/kegg/rest/keggapi.html
#List organisms
#http://rest.kegg.jp/list/organism
#curl -s -S http://rest.kegg.jp/list/organism | grep "mouse"
#echo "Enter code of the organism (three letter) followed by [ENTER]:" read organism;


#curl http://rest.kegg.jp/list/pathway/$organism | sed 's/path\://' | cut -f1
organism=$1;
DIR=$2;
mkdir -p $DIR/class/lib/db/${organism};
TOTAL=$(curl -g -s -S "https://rest.kegg.jp/list/pathway/$organism" | wc -l);
DT=`/bin/date`;
echo "processing started....$DT";
echo "Retreiving $TOTAL KEGG pathways for $organism";
echo "Do not panic. The processing is going on...";
PATHWAY=$(curl -g -s -S "https://rest.kegg.jp/list/pathway/$organism" | sed "s/path\://" | cut -f1);
(
for i in $PATHWAY; do
{

t1=$(curl -g -s -S "https://rest.kegg.jp/link/$organism/$i" | sed "s/path\://g" | sed "s/$organism\://g" | awk 'BEGIN{FS="\t"}{ if( !seen[$1]++ ) order[++oidx] = $1; stuff[$1] = stuff[$1] $2 "," } END { for( i = 1; i <= oidx; i++ ) print order[i]"\t"stuff[order[i]] }' | cut -f2 )

t2=$(curl -g -s -S "https://rest.kegg.jp/list/pathway/$organism" | grep -w "$i" | sed "s/path\://" | sed "s/\t/~/" | sed "s/ - /\t/" | cut -f1 | sed "s/ /_/g" )



echo "$t2***$t1"
}

done

)>$DIR/class/lib/db/${organism}/kegg_database.tmp1;

cat $DIR/class/lib/db/${organism}/kegg_database.tmp1 | sed "s/\*\*\*/\t/g" > $DIR/class/lib/db/${organism}/kegg_database.txt;




rm $DIR/class/lib/db/${organism}/kegg_database.tmp1;

echo "Database retreived..You are now ready to use geneSCF with organism $organism from --database KEGG";
DT=`/bin/date`;
echo "Done....$DT";
#perl replaceIDS.pl res_${organism}.txt geneSymWithID_9606.txt > res_${organism}_sym.txt;

#cat res_${organism}.txt |awk 'BEGIN { FS = "\t" } ; {print $1"\tKEGG\t"$2}' > res_${organism}_geneid.txt


