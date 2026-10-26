// Maps PolB fragments onto a ready-made PolB msa
process addfragments {

input:
path fragments
path msa

output:
path "mafftout.fasta"

script:

"""

mafft --addfragments ${fragments} --keeplength ${msa} > mafftout.fasta

"""

}


// Makes a jplace including refference PolB sequences and fragments from the data
process epa_ng {

publishDir "results", mode: 'copy'

input:
path msa
path tree
path mafftout
path model


output:
path "*.jplace"

script:

"""

epa-ng --split ${msa} ${mafftout}
epa-ng -s ${msa} -t ${tree} --query query.fasta --model ${model}

"""

}


// Builds the tree
process gappa {

publishDir "results", mode: 'copy'

input:
path epa

output:
path "*.newick"

script:

"""

gappa examine graft --jplace-path ${epa} > log

"""

}