# GeneSCF
Gene Set Clustering based on Functional annotation. Most up-to-date and realtime information based gene enrichment analysis.
<br><b><i>Publication</i></b>: 
<br>GeneSCF: a real-time based functional enrichment tool with support for multiple organisms. BMC Bioinformatics 17, 365 (2016).* https://doi.org/10.1186/s12859-016-1250-z

This documentation will provide detailed information on usage of GeneSCF tool (All versions).
Read following page for [running GeneSCF on test dataset](https://github.com/genescf/GeneSCF/wiki).

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



----------------------------
# Installation


Download and extract the compressed file using 'unzip' (for .zip file) or 'tar' (for .tar.gz file). Use it without any need for special installation procedures.<br>

- <b><i>Dependencies</i></b>: PERL<br>
- <b><i>Test required modules
</i></b>: awk, cat, unzip, gzip, wget, rm, mkdir, sort, date, sed, paste, join, grep, curl, echo <br>
- <b><i>For graphical output or plots</i></b>: If needed graphical output, pre installated <b>R (version > 3.0)</b> and '<b>ggplot2</b>' is required.<br>
<b><i>Note</i></b>: <br>
GeneSCF only works on Linux system, it has been successfully tested on Ubuntu, Mint and Cent OS. Other distributions of Linux might work as well.

<br>


----------------------------
# General usage

There are two utilities available from GeneSCF package. 

1. One is the main command line '*geneSCF*', to perform gene enrichment analysis.
2. Next, is the '*prepare_database*' command line to prepare the necessary database of an organism. GeneSCF by default comes with database for human consists of gene ontology, KEGG, Reactome, and NCG.

## 1. GeneSCF enrichment analysis - command line
``` r
./geneSCF -m=[update|normal] -i=[INPUT FILE] -t=[gid|sym] -o=[OUTPUT PATH/FOLDER/] -db=[GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME] -p=[yes|no] -bg=[#TotalGenes] -org=[see,org_codes_help]
```



<table>
  <tr><th>Available Parameters in geneSCF</th><th>Options</th><th>Description</th></tr>
  <tr><td>`[-m= | --mode=]`</td><td>normal<br>update</td><td>For normal mode use <i>normal</i> and for <i>update</i> mode use *update* without quotes</td></tr>
  <tr><td>`[-i= | --infile=]`</td><td>[INPUT-TEXT-FILE]</td><td>Input file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.The genes must be new lines seperated (One gene per line)</td></tr>
  <tr><td>`[-t= | --gtype=]`</td><td>gid<br>sym</td><td>Type of input in the provided list either Entrez GeneIDs <i>gid</i> or OFFICIAL GENE SYMBOLS <i>sym</i> (default: *gid*)</td></tr>
  <tr><td>`[-db= | --database=]`</td><td>GO_all<br>GO_BP<br>GO_CC<br>GO_MF<br>KEGG<br>REACTOME<br>NCG<br></td><td>Database to use as a source for finding gene enrichment, the options are either geneontology <i>GO_all</i> or geneontology-biological_process <i>GO_BP</i> or geneontology-molecular_function <i>GO_MF</i> or geneontology-cellular_components <i>GO_CC</i> or kegg <i>KEGG</i> or reactome <i>REACTOME</i> or Network of Cancer Genes <i>NCG</i></td></tr>
  <tr><td>`[-o= | --outpath=]`</td><td>[OUTPUT-DIRECTORY]</td><td>Existing directory to save output file (Don't forget to use trailing slash at end of the directory name). The output will be saved in the provided location as <i>{INPUT_FILE_NAME}_{database}_functional_classification.tsv<i> (tab-seperated file). **Note**: the specified folder should exist because GeneSCF does not create any output folder</td></tr>
  <tr><td>`[-bg= | --background=]`</td><td>[Total background]</td><td>Total number of genes to be considered as background (Example : ~<i>20,000<i> for human)</td></tr>
  <tr><td>`[-org= | --organism=]`</td><td>[<a href="https://github.com/genescf/GeneSCF/tree/master/org_codes_help">see organism codes</a>]</td><td>Please see organism codes (For human in KEGG -><i>hsa</i> in Geneontology -> <i>goa_human</i>). For database 'REACTOME' and 'NCG', only human organism is supported in GeneSCF and the organism code is 'Hs'.</td></tr>
  <tr><td>`[-p= | --plot=]`</td><td>yes<br>no</td><td>For additional graphical output use <i>yes</i> or <i>no<i>.This requires R version > 3.0 and <i>ggplot2</i> R package to be pre-installed on the system</td></tr>
  <tr><td>`[-h | --help]`</td><td></td><td> For displaying this help page</td></tr>

  </table>
  
  ## 2. Preparing database - command line
  ``` r
  ./prepare_database -db=[GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME|NCG] -org=[see,org_codes_help directory]
  ```
  
  <table>
  <tr><th>Available Parameters in geneSCF</th><th>Options</th><th>Description</th></tr>
  <tr><td>`[-db= | --database=]`</td><td>GO_all<br>GO_BP<br>GO_CC<br>GO_MF<br>KEGG<br>REACTOME<br>NCG<br></td><td>Database to use as a source for finding gene enrichment, the options are either geneontology <i>GO_all</i> or geneontology-biological_process <i>GO_BP</i> or geneontology-molecular_function <i>GO_MF</i> or geneontology-cellular_components <i>GO_CC</i> or kegg <i>KEGG</i> or reactome <i>REACTOME</i> or Network of Cancer Genes <i>NCG</i></td></tr>
  <tr><td>`[-org= | --organism=]`</td><td>[<a href="https://github.com/genescf/GeneSCF/tree/master/org_codes_help">see organism codes</a>]</td><td>Please see organism codes (For human in KEGG -><i>hsa</i> in Geneontology -> <i>goa_human</i>)</td>. For database 'REACTOME' and 'NCG', only human organism is supported in GeneSCF and the organism code is 'Hs'.</tr>
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
./prepare_database -db=GO_all -org=goa_human
  ```
  **Note:** Specific dabases can be also updated using 'GO_BP', 'GO_MF' and 'GO_CC'
  
 
 ### Updating GeneSCF with KEGG pathways for human
  
  ``` r
./prepare_database -db=KEGG -org=hsa
  ```
 
### Updating GeneSCF with Reactome pathways for human

  ``` r
./prepare_database -db=REACTOME -org=Hs
  ```
  
   **Note:** Reactome supports only Human (Hs)
  
  
  ### Updating GeneSCF with cancer genes human

  ``` r
./prepare_database -db=NCG -org=Hs
  ```
  
   **Note:** NCG supports only Human (Hs)
  
  
  ## Enrichment analysis
  
  
  ### Functional enrichment analysis using geneontology biological process (GO_BP)
  
  ``` r
./geneSCF -m=normal -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=GO_BP -bg=20000 --plot=yes -org=goa_human
  ```
  
  ### Pathway enrichment analysis using KEGG
  
  ``` r
./geneSCF -m=normal -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=KEGG -bg=20000 --plot=yes -org=hsa
  ```
  
  ***Note:*** All predicted results can be found in '***geneSCF-master-vx.x/test/output/***' folder with file name '***{INPUT_FILE_NAME}_{database}_functional_classification.tsv***'
  
  
  ## Single-step enrichment analysis
  
  This '-m=update' mode will integrate both 'prepare_database' and 'geneSCF' into single command mode. When you use 'update' mode once, you can use 'normal' mode for the next consecutive runs, in case you are planning to use the same database for different gene lists (This saves time).
  
  ### Functional enrichment analysis using geneontology biological process (GO_BP)
  
  ``` r
./geneSCF -m=update -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=GO_BP -bg=20000 --plot=yes -org=goa_human
  ```
  
  ### Pathway enrichment analysis using KEGG
  
  ``` r
./geneSCF -m=update -i=geneSCF-master-vx.x/test/H0.list -o=geneSCF-master-vx.x/test/output/ -t=sym -db=KEGG -bg=20000 --plot=yes -org=hsa
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
./geneSCF-master-vx.x/geneSCF-master-source-v1.1-p2/geneSCF_batch
```

# License

<a href="https://github.com/genescf/GeneSCF/blob/master/gpl-3.0.txt">GNU GENERAL PUBLIC LICENSE</a>


