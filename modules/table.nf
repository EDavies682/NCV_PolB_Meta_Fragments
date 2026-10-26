// Sorts info into a table
process table {

input:
tuple val(acc), path(seqs)

output:

path "${acc}_info.txt"

script:

"""


header=\$(grep '^>' "${seqs}")

identifier=\$(echo "\$header" | sed 's/>//' | sed 's/ .*//')

partial=\$(echo "\$header" | sed 's/.*partial=//' | sed 's/;.*//')

start_type=\$(echo "\$header" | sed 's/.*start_type=//' | sed 's/;.*//')

rbs_motif=\$(echo "\$header" | sed 's/.*rbs_motif=//' | sed 's/;.*//')

rbs_spacer=\$(echo "\$header" | sed 's/.*rbs_spacer=//' | sed 's/;.*//')

genetic_code=\$(echo "\$header" | sed 's/.*genetic_code=//' | sed 's/;.*//')

gc_cont=\$(echo "\$header" | sed 's/.*gc_cont=//' | sed 's/;rbs_spacer*//')


paste <(echo "\$identifier") <(echo "\$sequence") <(echo "\$partial") <(echo "\$start_type") <(echo "\$rbs_motif") <(echo "\$rbs_spacer") <(echo "\$genetic_code") <(echo "\$gc_cont") > ${acc}_info.txt

"""

}
