#!/bin/Rscript
rmarkdown::render("index.Rmd", "revealjs::revealjs_presentation",
                  output_file = "../index.html")
