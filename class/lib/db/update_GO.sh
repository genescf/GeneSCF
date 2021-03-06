#!/bin/bash
organism=$1;
DIR=$2;

bpath="$DIR/class/lib/db/$organism";
mkdir -p $bpath
rm $DIR/class/lib/db/gene_info_limit.gz;

echo "Downloading GO database...."
wget -P  $bpath/ http://purl.obolibrary.org/obo/go.obo --quiet;

## Edited and added 2017/01/13 ## BLOCK START
status=$(curl -s --head -w %{http_code} http://geneontology.org/gene-associations/${organism}.gaf.gz -o /dev/null)


#if [ $status -eq 200 ];
if [ $status -eq 200 ] || [ $status -eq 302 ]; # Updated 2019/03/19
then

	wget -P $bpath/ -O $bpath/gene_association.${organism}.gz http://geneontology.org/gene-associations/${organism}.gaf.gz --quiet; 

#fi
else
#if [[ "$status" -eq 404 ]]; then

	wget -P $bpath/ -O $bpath/gene_association.${organism}.gz http://geneontology.org/gene-associations/gene_association.${organism}.gz --quiet; 

fi
## Edited and added 2017/01/13 ## BLOCK END

echo "Extracting $organism information...";



gzip -d -f $bpath/gene_association.${organism}.gz;


cat $bpath/go.obo | grep "^id\:" | sed 's/id: //' >  $bpath/GO_id.txt;
cat $bpath/go.obo | grep "^name\:" | sed 's/name: //' >  $bpath/GO_desc.txt;
cat $bpath/go.obo | grep "^namespace\:" | sed 's/namespace: //' >  $bpath/GO_process.txt;

paste $bpath/GO_id.txt $bpath/GO_desc.txt $bpath/GO_process.txt | awk -F '\t' '{print $1"\t"$3"\t"$2;}' | grep "^GO:" > $bpath/GOWithDescProcess.txt;

org_taxid=`cat $bpath/gene_association.${organism} | grep -v "\!" | cut -f13 | head -n1 | sed 's/taxon\://'`;
cat $bpath/gene_association.${organism} | grep -v "\!" | awk 'BEGIN{FS="\t"}{if($12~"protein" || $12~"gene") print $3"\t"$5"\t"$9;}' | awk '!x[$0]++'>  $bpath/all_go.tmp;
cat $bpath/all_go.tmp | awk '{print $2"\t"$1}' >  $bpath/temp1.txt;

awk 'BEGIN{FS="\t"}{ if( !seen[$1]++ ) order[++oidx] = $1; stuff[$1] = stuff[$1] $2 "," } END { for( i = 1; i <= oidx; i++ ) print order[i]"\t"stuff[order[i]] }'  $bpath/temp1.txt >  $bpath/gene_association.grouped.txt;

cat $bpath/gene_association.grouped.txt | cut -f1 > $bpath/temp2.txt;

perl $DIR/class/scripts/common.pl $bpath/GOWithDescProcess.txt  $bpath/temp2.txt $DIR > $bpath/gene_association.grouped.annotation;



sort -k1 $bpath/gene_association.grouped.annotation > $bpath/gene_association.grouped.annotation.tmp1
sort -k1 $bpath/gene_association.grouped.txt | grep "^GO:" > $bpath/gene_association.grouped.txt.tmp1





awk -F"\t" 'NR==FNR {vals[$1] = $2"\t"$3; next} !($1 in vals) {vals[$1] = "0 0 0"} {$(NF+1) = vals[$1]; print}' $bpath/gene_association.grouped.annotation.tmp1 $bpath/gene_association.grouped.txt.tmp1 | sed 's/ /\t/' | sed 's/ /\t/' | awk -F"\t" '{print $1"~"$4"\t"$3"\t"$2;}' > $bpath/gene_association.grouped.annotated.txt;






cat $bpath/gene_association.grouped.annotated.txt | awk 'BEGIN{FS="\t"}{if($2~"molecular_function") print $1"\t"$3;}' >  $bpath/GO_MF_sym.txt;
cat $bpath/gene_association.grouped.annotated.txt | awk 'BEGIN{FS="\t"}{if($2~"cellular_component") print $1"\t"$3;}' >  $bpath/GO_CC_sym.txt;
cat $bpath/gene_association.grouped.annotated.txt | awk 'BEGIN{FS="\t"}{if($2~"biological_process") print $1"\t"$3;}' >  $bpath/GO_BP_sym.txt;
cat $bpath/gene_association.grouped.annotated.txt | awk 'BEGIN{FS="\t"}{print $1"\t"$3;}'>  $bpath/GO_all_sym.txt;


#WITH ID's
echo "Updating gene information...";
wget -P  $DIR/class/lib/db/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz --quiet;
echo "Do not panic. The processing is going on...";
gzip -d  $DIR/class/lib/db/gene_info.gz;
cat $DIR/class/lib/db/gene_info | grep -v "^#" | awk -F '\t' '{print $1"\t"$3"\t"$2;}' > $DIR/class/lib/db/gene_info_limit;
rm $DIR/class/lib/db/gene_info;




cat $DIR/class/lib/db/gene_info_limit | grep -w "^$org_taxid" | awk -F '\t' '{print $2"\t"$3;}' > $bpath/geneSymWithID.txt;
gzip $DIR/class/lib/db/gene_info_limit;

awk 'BEGIN{FS="\t"}{ if( !seen[$1]++ ) order[++oidx] = $1; stuff[$1] = stuff[$1] $2 "," } END { for( i = 1; i <= oidx; i++ ) print order[i]"\t"stuff[order[i]] }' $bpath/geneSymWithID.txt | sed 's/,$//' > $bpath/geneSymWithID_DupGrpd.txt;

perl $DIR/class/scripts/replaceIDS.pl $bpath/GO_MF_sym.txt $bpath/geneSymWithID_DupGrpd.txt $DIR > $bpath/GO_MF_gid.txt
perl $DIR/class/scripts/replaceIDS.pl $bpath/GO_CC_sym.txt $bpath/geneSymWithID_DupGrpd.txt $DIR > $bpath/GO_CC_gid.txt
perl $DIR/class/scripts/replaceIDS.pl $bpath/GO_BP_sym.txt $bpath/geneSymWithID_DupGrpd.txt $DIR > $bpath/GO_BP_gid.txt
perl $DIR/class/scripts/replaceIDS.pl $bpath/GO_all_sym.txt $bpath/geneSymWithID_DupGrpd.txt $DIR > $bpath/GO_all_gid.txt


rm $bpath/all_go.tmp $bpath/gene_association.${organism}  $bpath/gene_association.grouped.annotated.txt  $bpath/gene_association.grouped.annotation  $bpath/gene_association.grouped.txt $bpath/GO_desc.txt  $bpath/GO_id.txt  $bpath/GO_process.txt $bpath/GOWithDescProcess.txt $bpath/geneSymWithID.txt $bpath/geneSymWithID_DupGrpd.txt $bpath/gene_association.grouped.annotation.tmp1 $bpath/gene_association.grouped.txt.tmp1 $bpath/temp1.txt $bpath/temp2.txt $bpath/go.obo


echo "Database retreived..You are now ready to use geneSCF with organism $organism from --database GO";
DT=`/bin/date`;
echo "Done....$DT";

