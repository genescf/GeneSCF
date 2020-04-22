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

<center><img src="http://genescf.kandurilab.org/pics/workflow.png" width="250" height="350"></center>

