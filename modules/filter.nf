// Filters protein fragments produced by prodigal
process filter {

input:
tuple val(acc), path(seqs)
path(queries)

output:
tuple val(acc), path("filtered_prots.fasta")

script:

"""

makeblastdb -in ${seqs} -dbtype prot -out protdb

for q in ${queries.join(' ')}; do
blastp -db protdb -query \$q -out \${q}_blast.out -evalue 1e-5

awk '/Sequences producing significant alignments/{p=1; getline; next} p && NF==0{p=0} p{print \$1}' \${q}_blast.out >> blast_ids.txt
done

sort -u blast_ids.txt -o blast_ids.txt

rm protdb.*

seqkit grep -f blast_ids.txt ${seqs} > filtered_prots.fasta

"""

}