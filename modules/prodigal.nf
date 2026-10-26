// Runs prodigal-gv
process prodigal {

input:
tuple val(acc), path(seqs)

output:
tuple val(acc), path("proteins.fasta")

script:
"""

prodigal-gv  -p meta -i ${seqs} -a proteins.fasta

"""

}