#!/usr/bin/env nextflow

nextflow.enable.dsl=2


// Example usage:
// nextflow run main.nf \
// --acc /path/to/accession/list


// Parameters
params.acc = null


// Import modules
include { detect } from './modules/detect.nf'
include { prodigal } from './modules/prodigal.nf'
include { filter } from './modules/filter.nf'
include { table } from './modules/table.nf'
include { addfragments; epa_ng; gappa } from './modules/treemake.nf'
include { format } from './modules/format.nf'


workflow {

if( !params.acc ) error "Error: /path/to/accession/list not found"

acc_ch = Channel.fromPath(params.acc).splitText() { it.trim() }

query_ch = Channel.fromPath("./data/all_ref_polb.fasta").first()

msa_ch = Channel.fromPath("./data/trimmed54.fasta")
tree_ch = Channel.fromPath("./data/tree54.nwk")
model_ch = Channel.fromPath("./data/eval_model.raxml.bestModel")


detect_ch = detect(acc_ch, query_ch)
	.filter { acc, fasta -> fasta.size() > 0 }

prodigal_ch = prodigal(detect_ch)

filter_ch = filter(prodigal_ch, query_ch)


table_ch = table(filter_ch)


all_tables_ch = table_ch
	.collectFile(name: 'all_info.csv', keepHeader: false, newLine: true)

all_seqs_ch = filter_ch
	.map { acc, faa -> faa }
	.collectFile(name: 'all_contigs.fasta', keepHeader: false, newLine: true)

addfragments_ch = addfragments(all_seqs_ch, msa_ch)
epa_ch = epa_ng(msa_ch, tree_ch, addfragments_ch, model_ch)
gappa_ch = gappa(epa_ch)

r_ch = format(gappa_ch, epa_ch, all_tables_ch)

}




