# GeneSCF
Gene Set Clustering based on Functional annotation. Most up-to-date and realtime information based gene enrichment analysis.
<br><b><i>Publication</i></b>: 
<br>GeneSCF: a real-time based functional enrichment tool with support for multiple organisms. BMC Bioinformatics 17, 365 (2016).* https://doi.org/10.1186/s12859-016-1250-z

This documentation will provide detailed information on usage of GeneSCF tool (All versions).
Read following page for [running GeneSCF on test dataset](https://github.com/genescf/GeneSCF/wiki).

----------------------------
# Table of Contents
----------------------------

   * [Overview](#overview)
   * [Installation](#installation)
   * [Command and subcommands](#command-and-subcommands)
   * [GeneSCF 1.1 detailed usage (Recent version)](#genescf-1.1-detailed-usage)
      * [Input files](#genescf-v1.0-input)
      * [Command and options](#Command-and-options)
      * [Output files](#output-files)
         * [TSV](#tsv)
         * [Image](#image)
         * [GeneMap](#genemap)
      * [Other output files](#other-output-files)
   * [License](#license)


----------------------------
# Overview
----------------------------

GeneSCF is a command line based and powerful tool to perform gene enrichment analysis. GeneSCF uses realtime informatin from repositories such as geneontology, KEGG, Reactome and NCG while performing the analysis. This increases reliability of the outcome compared to other available tools. GeneSCF is command line tool designed to easily integrate with any next-generation sequencing analysis pipelines. One can use multiple gene list in parallel to save time. In simple terms,

- Real-time analysis, do not have to depend on enrichment tools to get updated.
- Easy for computational biologists to integrate this simple tool with their NGS pipeline.
- GeneSCF supports more organisms.
- Enrichment analysis for Multiple gene list in single run.
- Enrichment analysis for Multiple gene list using Multiple source database (GO,KEGG, REACTOME and NCG) in single run.
- Download complete GO terms/Pathways/Functions with associated genes as simple table format in a plain text file (Check "Two step process" below in "GeneSCF USAGE" section).

<p align="center"> <img src="http://genescf.kandurilab.org/pics/workflow.png" width="250" height="350"> </p>

----------------------------
# Installation
----------------------------

Download and extract the compressed file using 'unzip' (for .zip file) or 'tar' (for .tar.gz file). Use it without any need for special installation procedures.<br>

- <b><i>Dependencies</i></b>: PERL<br>
- <b><i>Test required modules
</i></b>: awk, cat, unzip, gzip, wget, rm, mkdir, sort, date, sed, paste, join, grep, curl, echo <br>
- <b><i>For graphical output or plots</i></b>: If needed graphical output, pre installated <b>R (version > 3.0)</b> and '<b>ggplot2</b>' is required.<br>
- <b><i>Note</i></b>: <br>
<p style="color:#0000FF">GeneSCF only works on Linux system, it has been successfully tested on Ubuntu, Mint and Cent OS. Other distributions of Linux might work as well.</p>

<br>

![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#1589F0`


----------------------------
# Command and options
----------------------------

``` r
./geneSCF -m=[update|normal] -i=[INPUT FILE] -t=[gid|sym] -o=[OUTPUT PATH/FOLDER/] -db=[GO_all|GO_BP|GO_MF|GO_CC|KEGG|REACTOME] -p=[yes|no] -bg=[#TotalGenes] -org=[see,org_codes_help]
```

| Options         | Description                                     |
|--------------------------------|----------------------------------------------------------------------------|
| `[-m= \| --mode=]` | For normal mode use *normal* and for update mode use *update* without quotes.     |
| `[-i= \| --infile=]`  | Input file contains list of Entrez GeneIDs or OFFICIAL GENE SYMBOLS.The genes must be new lines seperated (One gene per line).      |
| `[-t= \| --gtype=]`   | Type of input in the provided list either Entrez GeneIDs *gid* or OFFICIAL GENE SYMBOLS *sym* (default: *gid*).         |
| `[-db= \| --database=]` | Database to use as a source for finding gene enrichment, the options are either geneontology *GO_all* or geneontology-biological_process *GO_BP* or geneontology-molecular_function *GO_MF* or geneontology-cellular_components *GO_CC* or kegg *KEGG* or reactome *REACTOME* or Network of Cancer Genes *NCG*. \|
| `[-o= \| --outpath=]`     | Existing directory to save output file (Don't forget to use trailing slash at end of the directory name). The output will be saved in the provided location as *{INPUT_FILE_NAME}_{database}_functional_classification.tsv* (tab-seperated file). **Note**: the specified folder should exist because GeneSCF does not create any output folder.                            |
| `[-bg= \| --background=]`     | Total background genes to consider (Example : ~*20,000* for human).                           |
| `[-org= \| --organism=]` | Please see organism codes(For human in KEGG ->*hsa* in Geneontology -> *goa_human*).          |
| `[-p= \| --plot=]`      | For additional graphical output use *yes* or *no*.This requires R version > 3.0 and *ggplot2* R package to be pre-installed on the system.     |
| `[-h \| --help]`    | For displaying this help page.         |

Some table

<table>
  <tr><th>Parameters</th><th>Options</th><th>Description</th></tr>
  <tr><td>`[-m= | --mode=]`</td><td>normal/update</td><td>For normal mode use *normal* and for <br>update mode use *update* without quotes</td></tr>
  <tr><td>`[-i= | --infile=]`</td><td></td><td>Input file contains list of Entrez GeneIDs or <br>OFFICIAL GENE SYMBOLS.The genes must <br>be new lines seperated (One gene per line)</td></tr>
  <tr><td>`[-t= | --gtype=]`</td><td></td><td>Type of input in the provided list either Entrez <br>GeneIDs *gid* or OFFICIAL GENE SYMBOLS <br>*sym* (default: *gid*)</td></tr>
  <tr><td>`[-db= | --database=]`</td><td></td><td>Database to use as a source for finding gene <br>enrichment, the options are either geneontology *GO_all* or<br> geneontology-biological_process *GO_BP* or geneontology-molecular_function *GO_MF* or geneontology-cellular_components *GO_CC* or kegg *KEGG* <br>or reactome *REACTOME* or Network of Cancer Genes *NCG*</td></tr>
  <tr><td>`[-o= | --outpath=]`</td><td></td><td>Existing directory to save output file <br>(Don't forget to use trailing slash at end of the directory name). <br>The output will be saved in the provided location as *{INPUT_FILE_NAME}_{database}_functional_classification.tsv* <br>(tab-seperated file). **Note**: the specified folder should exist because GeneSCF does not create any output folder</td></tr>
  <tr><td>`[-bg= | --background=]`</td><td></td><td>Total background genes to consider <br>(Example : ~*20,000* for human)</td></tr>
  <tr><td>`[-org= | --organism=]`</td><td></td><td>Please see organism codes<br>(For human in KEGG ->*hsa* in Geneontology -> *goa_human*)</td></tr>
  <tr><td>`[-p= | --plot=]`</td><td></td><td>For additional graphical output <br>use *yes* or *no*.This requires R version > 3.0 and *ggplot2* R package to be pre-installed on the system</td></tr>
  <tr><td>`[-h | --help]`</td><td></td><td> For displaying this help page</td></tr>

  </table>

