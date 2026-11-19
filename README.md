# NCV_PolB_Meta_Fragments

## Introduction
NCV-PolB_Meta_Fragments is a nextflow pipeline that identifies, extracts, and analyses potential fragments of the giant virus DNA polymerase B gene from metagenomic data.

Project Status: Work in Progress (WIP)

![workflow visualisation](images/visualised_workflow.jpg)

## Pipeline summary

1. Takes input as path to accession list.
2. Runs a loose blastx against a selection of known giant virus PolB from phylogenetically diverse species. Extracts reads with significant hits.
3. Runs prodigal-gv on the extracted reads, followed by a tighter blastp search to filter the putative protein fragments.
4. Maps the putative protein fragments onto an existing reference giant virus PolB gene phylogeny.
5. Outputs summary of findings in HTML format.

## Usage

Nextflow is required to run this pipeline. For information on how to download nextflow, please refer to [this page](https://nf co.re/docs/get_started/environment_setup/nextflow).

First clone the repository:

```bash

git clone https://github.com/EDavies682/NCV_PolB_Meta_Fragments.git
cd 

```

Then create the environment:

```bash

conda env create --file environment.yml

```

Now the pipeline is ready to be run:

```bash

nextflow run main.nf --acc /path/to/accession/list

```



