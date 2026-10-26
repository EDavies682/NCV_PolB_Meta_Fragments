// Runs R script to summarise outputs in a html
process format {

publishDir "results", mode: 'copy'

input:
path tree
path jplace
path data

output:
path "*.html"

script:
"""

Rscript -e "rmarkdown::render('${projectDir}/bin/PolB.Rmd',
output_file = 'report.html', knit_root_dir = getwd(), output_dir = getwd())" ${tree} ${jplace} ${data}

"""

}
