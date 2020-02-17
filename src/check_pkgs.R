req_packages <- c("readr", "hashmap", "reticulate")
for (pkg in req_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    require(pkg, character.only = TRUE)
  }
}
