# NCV_PolB_Meta_Fragments

## Introduction
NCV-PolB_Meta_Fragments is a nextflow pipeline that identifies, extracts, and analyses potential fragments of the giant virus DNA polymerase B gene from metagenomic data.

Project Status: Work in Progress (WIP)

![workflow visualisation](images/visualised_workflow.jpg)

## Pipeline summary

1. Takes input as path to accession list.
2. Runs a loose blastx against a selection of known giant virus PolB from phylogenetically diverse species. Extracts reads with significant hits.
3. Runs prodigal-gv on the extracted reads.
4. Maps the predicted protein fragments onto an existing reference giant virus PolB gene phylogeny.
5. Outputs summary of findings in HTML format.
