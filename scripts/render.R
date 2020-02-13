#!/bin/Rscript
req_packages <- c("rmarkdown", "revealjs")
for (pkg in req_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    require(pkg, character.only = TRUE)
  }
}

rmarkdown::render("index.Rmd", "revealjs::revealjs_presentation",
                  output_file = "../index.html")
