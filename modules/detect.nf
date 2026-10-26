// Downloads fastq file from SRA, runs quality control, and extracts sequences with similarity to PolB
process detect {

maxForks 1

input:
val acc
path queries

output:
tuple val(acc), path("blast_seqs.fasta")

script:
"""

fasterq-dump ${acc} -o raw.fastq --concatenate-reads

fastp -i raw.fastq -o fpout.fastq

rm raw.fastq

seqkit fq2fa fpout.fastq -o fpout.fasta

rm fpout.fastq

makeblastdb -in fpout.fasta -dbtype nucl -out mydb

for q in ${queries.join(' ')}; do
tblastn -db mydb -query \$q -out \${q}_blast.out -evalue 1e-1

awk '/Sequences producing significant alignments/{p=1; getline; next} p && NF==0{p=0} p{print \$1}' \${q}_blast.out >> blast_ids.txt
done

sort -u blast_ids.txt -o blast_ids.txt

rm mydb.*

seqkit grep -f blast_ids.txt fpout.fasta > blast_seqs.fasta

rm fpout.fasta

"""

}
