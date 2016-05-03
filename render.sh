#/bin/bash
Rscript -e "rmarkdown::render('report.Rmd')"
mv report.html index.html