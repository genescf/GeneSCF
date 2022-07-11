
<table><tr><td><img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/genescf/GeneSCF/total"></td><td><img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/genescf/GeneSCF"></td></tr></table>

<b>Note (JFY):</b> GeneSCF was recently (September 2020) moved to GitHub. It has been downloaded 5,325 times when hosted on http://genescf.kandurilab.org

<b>Important:</b> Always download latest stable release. To download latest release <a href="https://github.com/genescf/GeneSCF/releases/download/v1.1-p3/geneSCF-master-v1.1-p3.tar.gz">click here</a>. Check here for <a href="https://github.com/genescf/GeneSCF/releases">other releases</a>.


<!--table border=0><tr><td><img alt="GitHub Releases (by Asset)" src="https://img.shields.io/github/downloads/genescf/GeneSCF/v1.1/geneSCF-master-v1.1-p2.tar.gz"></td>
<td><img alt="GitHub Releases (by Asset)" src="https://img.shields.io/github/downloads/genescf/GeneSCF/v1.0/geneSCF-master-v1.0.tar.gz"></td></tr></table-->

# GeneSCF
Gene Set Clustering based on Functional annotation. Most up-to-date and realtime information based gene enrichment analysis.
<br><b><i>Publication</i></b>: 
<br>GeneSCF: a real-time based functional enrichment tool with support for multiple organisms. BMC Bioinformatics 17, 365 (2016). https://doi.org/10.1186/s12859-016-1250-z

This documentation will provide detailed information on usage of GeneSCF tool (All versions).
Read following page for [running GeneSCF on test dataset](#Step-by-step-instructions).

<a href="https://twitter.com/GeneSCF"><img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/GeneSCF?style=social"></a>

----------------------------
# Table of Contents


   - [Overview](#overview)
   - [Installation](#installation)
   - [General usage](#general-usage)
   - [Step-by-step instructions (simple usage)](#Step-by-step-instructions)
      + [Preparing database](#Preparing-database)
      + [Enrichment analysis](#Enrichment-analysis)
      + [Single-step enrichment analysis](#Single-step-enrichment-analysis)
   - [GeneSCF batch analysis](#GeneSCF-batch-analysis)
      + [Preparing arguments file](#Preparing-arguments-file)
      + [Edit batch script](#Edit-batch-script)
      + [Run batch analysis](#Run-batch-analysis)
   - [License](#License)



----------------------------
# Overview


GeneSCF is a command line based and powerful tool to perform gene enrichment analysis. GeneSCF uses realtime informatin from repositories such as geneontology, KEGG, Reactome and NCG while performing the analysis. This increases reliability of the outcome compared to other available tools. GeneSCF is command line tool designed to easily integrate with any next-generation sequencing analysis pipelines. One can use multiple gene list in parallel to save time. In simple terms,

- Real-time analysis, do not have to depend on enrichment tools to get updated.
- Easy for computational biologists to integrate this simple tool with their NGS pipeline.
- GeneSCF supports more organisms.
- Enrichment analysis for Multiple gene list in single run.
- Enrichment analysis for Multiple gene list using Multiple source database (GO,KEGG, REACTOME and NCG) in single run.
- Download complete GO terms/Pathways/Functions with associated genes as simple table format in a plain text file. Check [Preparing database](#Preparing-database) under [Step-by-step instructions (simple usage)](#Step-by-step-instructions) section for the details.

<p align="center"> <img src="http://genescf.kandurilab.org/pics/workflow.png" width="250" height="350"> </p>

<p align="center"> <img src="https://media.springernature.com/lw685/springer-static/image/art%3A10.1186%2Fs12859-016-1250-z/MediaObjects/12859_2016_1250_Fig2_HTML.gif" width="250" height="250"><img src="https://media.springernature.com/lw685/springer-static/image/art%3A10.1186%2Fs12859-016-1250-z/MediaObjects/12859_2016_1250_Fig3_HTML.gif" width="250" height="250"><img src="https://media.springernature.com/lw685/springer-static/image/art%3A10.1186%2Fs12859-016-1250-z/MediaObjects/12859_2016_1250_Fig4_HTML.gif" width="250" height="250"></p>

Above graphs are from <a href="https://doi.org/10.1186/s12859-016-1250-z" target="new"><i>Subhash and Kanduri et al.</i>, 2016 </a>

----------------------------
# Installation


Download and extract the compressed file using 'unzip' (for .zip file) or 'tar' (for .tar.gz file). Use it without any need for special installation procedures.<br>

- <b><i>Dependencies</i></b>: PERL<br>
- <b><i>Test required modules
</i></b>: awk, cat, unzip, gzip, wget, rm, mkdir, sort, date, sed, paste, join, grep, curl, echo <br>
- <b><i>For graphical output or plots</i></b>: If needed graphical output, pre installated <b>R (version > 3.0)</b> and '<b>ggplot2</b>' is required.<br>
<b><i>Note</i></b>: GeneSCF only works on Linux system, it has been successfully tested on Ubuntu, Mint and Cent OS. Other distributions of Linux might work as well.

<br>


----------------------------
# General usage

There are two utilities available from GeneSCF package. 

1. One is the main command line '*geneSCF*', to perform gene enrichment analysis.
2. Next, is the '*prepare_database*' command line to prepare the necessary database of an organism. GeneSCF by default comes with database for human consists of gene ontology, KEGG, Reactome, and NCG.

<b>Note:</b> Replace '<i>geneSCF-master-vx.x</i>' from the commands with your GeneSCF directory.

## 1. GeneSCF enrichment analysis - command line
``` r
./geneSCF-master-vx.x/geneSCF -m=[update|normal] -i=[INPUT FILE] -t=[gid|sym] -o=[OUTPUT PATH/FOLDER/] -db=[GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME] -p=[yes|no] -bg=[#TotalGenes] -org=[see,org_codes_help]
```



<table>
  <tr><th>Available Parameters in geneSCF</th><th>Options</th><th>Description</th></tr>
  <tr><td> <i>-m=</i> <b>|</b> <i>--mode=</i> </td><td>normal<br>update</td><td>For normal mode use <i>normal</i> and for <i>update</i> mode use *update* without quotes</td></tr>
  <tr><td> <i>-i=</i> <b>|</b> <i>--infile=</i> </td><td>[INPUT-TEXT-FILE]</td><td>Input file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.The genes must be new lines seperated (One gene per line)</td></tr>
  <tr><td> <i>-t=</i> <b>|</b> <i>--gtype=</i> </td><td>gid<br>sym</td><td>Type of input in the provided list either Entrez GeneIDs <i>gid</i> or OFFICIAL GENE SYMBOLS <i>sym</i> (default: *gid*)</td></tr>
  <tr><td> <i>-db=</i> <b>|</b> <i>--database=</i> </td><td>GO_all<br>GO_BP<br>GO_CC<br>GO_MF<br>KEGG<br>REACTOME<br>NCG<br></td><td>Database to use as a source for finding gene enrichment, the options are either geneontology <i>GO_all</i> or geneontology-biological_process <i>GO_BP</i> or geneontology-molecular_function <i>GO_MF</i> or geneontology-cellular_components <i>GO_CC</i> or kegg <i>KEGG</i> or reactome <i>REACTOME</i> or Network of Cancer Genes <i>NCG</i></td></tr>
  <tr><td> <i>-o=</i> <b>|</b> <i>--outpath=</i> </td><td>[OUTPUT-DIRECTORY]</td><td>Existing directory to save output file (Don't forget to use trailing slash at end of the directory name). The output will be saved in the provided location as <i>{INPUT_FILE_NAME}_{database}_functional_classification.tsv<i> (tab-seperated file). **Note**: the specified folder should exist because GeneSCF does not create any output folder</td></tr>
  <tr><td> <i>-bg=</i> <b>|</b> <i>--background=</i> </td><td>[Total background]</td><td>Total number of genes to be considered as background (Example : ~<i>20,000</i> for human). It is important to choose the background appropriately. Sometimes your samples do not express all the genes. For example, if you are using differentially expressed genes for gene set enrichment analysis, you must choose total number of genes detected in your experiment including control and treatment samples irrespective of their differential status as your background (NOT the total number of genes in the annotation of the corresponding organism you are working with). All the genes from the annotation can be used when working with genes found in genome-wide studies (example, ChIP-seq, WGBS, etc.,).</td></tr>
  <tr><td> <i>-org=</i> <b>|</b> <i>--organism=</i> </td><td>[<a href="https://github.com/genescf/GeneSCF/tree/master/org_codes_help">see organism codes</a>]</td><td>Please see organism codes (For human in KEGG -><i>hsa</i> in Geneontology -> <i>goa_human</i>). For database 'REACTOME' and 'NCG', only human organism is supported in GeneSCF and the organism code is 'Hs'.</td></tr>
  <tr><td> <i>-p=</i> <b>|</b> <i>--plot=</i> </td><td>yes<br>no</td><td>For additional graphical output use <i>yes</i> or <i>no<i>.This requires R version > 3.0 and <i>ggplot2</i> R package to be pre-installed on the system</td></tr>
  <tr><td> <i>-h</i> <b>|</b> <i>--help</i> </td><td></td><td> For displaying this help page</td></tr>

  </table>
  
  ## 2. Preparing database - command line
  ``` r
  ./geneSCF-master-vx.x/prepare_database -db=[GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME] -org=[see,org_codes_help directory]
  ```
  <b>Note:</b> The above command downloads complete '-db' of your choice as simple text file with corresponding genes per GO term in following location, '<b>geneSCF-master-vx.x/class/lib/db/[ORGANISM]/</b>' for your prefered organism.
  
  <table>
  <tr><th>Available Parameters in prepare_database</th><th>Options</th><th>Description</th></tr>
  <tr><td><i>-db=</i> <b>|</b> <i>--database=</i></td><td>GO_all<br>GO_BP<br>GO_CC<br>GO_MF<br>KEGG<br>REACTOME<br>NCG<br></td><td>Database to use as a source for finding gene enrichment, the options are either geneontology <i>GO_all</i> or geneontology-biological_process <i>GO_BP</i> or geneontology-molecular_function <i>GO_MF</i> or geneontology-cellular_components <i>GO_CC</i> or kegg <i>KEGG</i> or reactome <i>REACTOME</i> </td></tr>
  <tr><td><i>-org=</i> <b>|</b> <i>--organism=</i></td><td>[<a href="https://github.com/genescf/GeneSCF/tree/master/org_codes_help">see organism codes</a>]</td><td>Please see organism codes (For human in KEGG -><i>hsa</i> in Geneontology -> <i>goa_human</i>). For database 'REACTOME' and 'NCG', only human organism is supported in GeneSCF and the organism code is 'Hs'.</td></tr>
  </table>
  
  ----------------------------
# Step-by-step instructions

For a convenience we will use test datasets from the directory 'geneSCF-master-vx.x/test/'. There are two steps involved,
1. Prepare your prefered database for an organism of your interest.
2. Perform enrichment analysis on your gene list.
3. One can also perform enrichment analysis in single-step using 'update' mode.


## Preparing database


### Updating GeneSCF with complete geneontology database for human

  ``` r
./geneSCF-master-vx.x/prepare_database -db=GO_all -org=goa_human
  ```
  **Note:** Specific dabases can be also updated using 'GO_BP', 'GO_MF' and 'GO_CC'. The above command downloads complete geneontology ('GO_all') with corresponding genes per GO term as simple text file in following location, '<b>geneSCF-master-vx.x/class/lib/db/goa_human/</b>'.
  
 
 ### Updating GeneSCF with KEGG pathways for human
  
  ``` r
./geneSCF-master-vx.x/prepare_database -db=KEGG -org=hsa
  ```
 
### Updating GeneSCF with Reactome pathways for human

  ``` r
./geneSCF-master-vx.x/prepare_database -db=REACTOME -org=Hs
  ```
  
   **Note:** Reactome supports only Human (Hs)
  
  
  ### Updating GeneSCF with cancer genes human

  ``` r
./geneSCF-master-vx.x/prepare_database -db=NCG -org=Hs
  ```
  
   **Note:** NCG supports only Human (Hs)
  
  
  ## Enrichment analysis
  
  
  ### Functional enrichment analysis using geneontology biological process (GO_BP)
  
  ``` r
./geneSCF-master-vx.x/geneSCF -m=normal -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=GO_BP -bg=20000 --plot=yes -org=goa_human
  ```
  
  ### Pathway enrichment analysis using KEGG
  
  ``` r
./geneSCF-master-vx.x/geneSCF -m=normal -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=KEGG -bg=20000 --plot=yes -org=hsa
  ```
  
 <b>Note:</b> All predicted results can be found in '***geneSCF-master-vx.x/test/output/***' folder with file name '***{INPUT_FILE_NAME}_{database}_functional_classification.tsv***'
  
  
  ## Single-step enrichment analysis
  
  This '-m=update' mode will integrate both 'prepare_database' and 'geneSCF' into single command mode. When you use 'update' mode once, you can use 'normal' mode for the next consecutive runs, in case you are planning to use the same database for different gene lists (This saves time).
  
  ### Functional enrichment analysis using geneontology biological process (GO_BP)
  
  ``` r
./geneSCF-master-vx.x/geneSCF -m=update -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=GO_BP -bg=20000 --plot=yes -org=goa_human
  ```
    **Note:** The above command also downloads complete geneontology biological processes ('GO_BP') with corresponding genes per GO term as a simple text file in following location, '<b>geneSCF-master-vx.x/class/lib/db/goa_human/</b>' and also does enrichment analysis in parallel. The results for enrichment analysis can be found in folder '<b>geneSCF-master-vx.x/test/output/</b>'.
  
  ### Pathway enrichment analysis using KEGG
  
  ``` r
./geneSCF-master-vx.x/geneSCF -m=update -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=KEGG -bg=20000 --plot=yes -org=hsa
  ```
  
  ***Note:*** All predicted results can be found in '***geneSCF-master-vx.x/test/output/***' folder with file name '***{INPUT_FILE_NAME}_{database}_functional_classification.tsv***'
  
 
 ----------------------------
# GeneSCF batch analysis
 
## Preparing arguments file

Edit file '***./geneSCF-master-vx.x/db_batch_config.txt***' to configure your parameters for batch run. The sample file looks like the one below,

``` r
#database:organism:background:type
#GO_BP:goa_human:20000:sym
#GO_MF:goa_human:20000:sym
GO_CC:goa_human:20000:sym
KEGG:hsa:20000:sym
#REACTOME:Hs:20000:sym
NCG:Hs:20000:sym
```
In the above file you are asking GeneSCF to run enrichment analysis using 'GO_CC', 'KEGG', and 'NCG' database for human. The database mentioned with preceeding '#' will not be considered for the run.


## Edit batch script

Edit script '***./geneSCF-master-vx.x/geneSCF_batch***' for your input files (files_path) and output path (output_path).

``` r
files_path="/FOLDER/WHERE/GENE_LISTS/STORED"
output_path="/FOLDER/PATH/FOR/OUTPUT"
```

**Note:**
 - It is recommended to keep all input files in same folder.
 - Inside specified output folder path GeneSCF will automatically create individual sub-folders for each gene list.


## Run batch analysis

Execute batch analysis.

``` r
./geneSCF-master-vx.x/geneSCF_batch
```

# License

<a href="https://github.com/genescf/GeneSCF/blob/master/gpl-3.0.txt">GNU GENERAL PUBLIC LICENSE</a>


